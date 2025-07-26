// ignore_for_file: unused_import, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations, unnecessary_import, deprecated_member_use, unused_local_variable, non_constant_identifier_names, avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:notepad/provider/pref-provider.dart';
import 'package:notepad/screens/search-screen.dart';
import 'package:notepad/utils/custom-bottom-sheet.dart';
import 'package:notepad/widgets/empty-category.dart';
import 'package:notepad/widgets/note-card.dart';
import 'package:notepad/widgets/note-tile.dart';
import 'package:provider/provider.dart';
import '../hive/boxes.dart';
import '../hive/notes_model.dart';
import '../provider/addnotes_provider.dart';
import '../provider/homescreen_provider.dart';
import '../utils/utils.dart';
import '../widgets/addNote_btn.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/empty_home_screen.dart';
import '../widgets/custom-bottom-nav.dart';
import 'add_note.dart';
import 'reading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, Color> _categoryColor = {
    'Work': const Color(0xFF4FC3F7),
    'Personal': Color(0xFFFF8A65),
    'Idea': Color(0xFFFFD54F),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Box<NotesModel> notesBox;
  bool _showFab = true;
  PersistentBottomSheetController? _bottomSheetController;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<NotesModel>('notes');
    Provider.of<HomescreenProvider>(context, listen: false)
        .setNotesBox(notesBox);
    Provider.of<HomescreenProvider>(context, listen: false).setSearch(false);
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<AddNotesProvider>(context);
    final prefProvider = Provider.of<PrefProvider>(context, listen: true);
    var provider = Provider.of<HomescreenProvider>(context, listen: true);

    print("Hello");
    return WillPopScope(
      onWillPop: () async {
        provider.clearSelection();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Consumer<HomescreenProvider>(builder: (context, note, _) {
            return !note.isMultiSelection
                ? Text(
                    "NotePad",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  )
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          note.clearSelection();
                        },
                        icon: Icon(
                          Icons.close,
                          // color: Colors.white
                        ),
                      ),
                      Text(note.getSelectedItemCount())
                    ],
                  );
          }),
          actions: [
            Consumer<HomescreenProvider>(builder: (context, provider, _) {
              return Visibility(
                  visible: !provider.isMultiSelection,
                  child: Consumer<PrefProvider>(builder: (context, value, _) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              value.toggleNoteCard(value: !value.isNotesCard);
                            },
                            icon: value.isNotesCard
                                ? Icon(Icons.grid_view
                                    // color: Colors.white,
                                    )
                                : Icon(
                                    Icons.list,
                                  ),
                          ),
                          IconButton(
                            onPressed: () {
                              value.toggleDarkMode(value: !value.isDarkMode);
                            },
                            icon: Icon(
                              value.isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                            ),
                          ),
                        ]);
                  }));
            }),
            Consumer<HomescreenProvider>(
              builder: (context, provider, _) {
                return Visibility(
                    visible: provider.isMultiSelection,
                    child: TextButton.icon(
                        onPressed: () {
                          provider.toggleSelectAll();
                        },
                        label: Text('Select All'),
                        icon: Icon(
                          //one bug is select select all by category....
                          provider.selectedCategory == "All"
                              ? provider.selectedItem.length ==
                                      provider.notesBox.length
                                  ? Icons.check
                                  : Icons.check_box_outline_blank
                              : provider.selectedItem.length ==
                                      provider.notesBox.values
                                          .where((note) =>
                                              note.category ==
                                              provider.selectedCategory)
                                          .length
                                  ? Icons.check
                                  : Icons.check_box_outline_blank,
                          // color: provider.selectedItem.length ==
                          //         provider.notesBox.length
                          //     ? Colors.black
                          //     : Colors.white,
                        )));
              },
            )
          ],
        ),
        // drawer: CustomDrawer(),
        body: GestureDetector(
          behavior: HitTestBehavior
              .translucent, // Allows tap through transparent areas
          onTap: () {
            if (_bottomSheetController != null) {
              _bottomSheetController!.close();
              _bottomSheetController = null;
              setState(() => _showFab = true);
            }
          },

          child: ValueListenableBuilder<Box<NotesModel>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              var data = box.values.toList().cast<NotesModel>();
              return data.isEmpty
                  ? EmptyHomeScreen()
                  : data
                              .where((note) =>
                                  note.category == provider.selectedCategory)
                              .isEmpty &&
                          provider.selectedCategory != 'All'
                      ? EmptyCategory(ctg: provider.selectedCategory)
                      : prefProvider.isNotesCard
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: provider.selectedCategory == "All"
                                  ? data.length
                                  : data
                                      .where((note) =>
                                          note.category ==
                                          provider.selectedCategory.toString())
                                      .length,
                              itemBuilder: (BuildContext context, int index) {
                                var filterNote = data
                                    .where((note) =>
                                        note.category ==
                                        provider.selectedCategory)
                                    .toList();
                                return provider.selectedCategory == "All"
                                    ? NoteCard(
                                        note: data[index],
                                        categoryColor: _categoryColor)
                                    : NoteCard(
                                        note: filterNote[index],
                                        categoryColor: _categoryColor);
                              },
                            )
                          : ListView.builder(
                              itemCount: provider.selectedCategory == "All"
                                  ? data.length
                                  : data
                                      .where((note) =>
                                          note.category ==
                                          provider.selectedCategory.toString())
                                      .length,
                              itemBuilder: (context, index) {
                                var filterNote = data
                                    .where((note) =>
                                        note.category ==
                                        provider.selectedCategory)
                                    .toList();

                                bool TitlerightSide =
                                    data[index].isTitleRightSided ?? false;
                                bool noteRightSided =
                                    data[index].isNotesRightSided ?? false;
                                return provider.selectedCategory == "All"
                                    ? NoteTile(
                                        note: data[index],
                                        categoryColor: _categoryColor)
                                    : NoteTile(
                                        note: filterNote[index],
                                        categoryColor: _categoryColor);
                              });
            },
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBar(
            elevation: 25,
            shadowColor: Colors.black, // Make shadow visible
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.menu, size: 30),
                    onPressed: () {
                      if (_bottomSheetController != null) {
                        // Close the sheet if already open
                        _bottomSheetController!.close();
                        _bottomSheetController = null;
                        setState(() => _showFab = true);
                      } else {
                        // Open new sheet
                        _bottomSheetController =
                            scaffoldKey.currentState?.showBottomSheet(
                          (context) => GestureDetector(
                            // This prevents taps inside the sheet from closing it
                            behavior: HitTestBehavior.opaque,
                            child: CustomBottomSheet(),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(25)),
                          ),
                          elevation: 10,
                        );

                        setState(() => _showFab = false);

                        _bottomSheetController?.closed.then((_) {
                          if (mounted) {
                            setState(() {
                              _bottomSheetController = null;
                              _showFab = true;
                            });
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 40), // Space for the FAB
                  IconButton(
                    icon: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      provider.setSearch(true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        floatingActionButton: _showFab ? AddNoteBtn() : null,
        // bottomNavigationBar : CustomBottomNavBar(onFabPressed: (){}, onMenuPressed: (){}, onSearchPressed: (){}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
