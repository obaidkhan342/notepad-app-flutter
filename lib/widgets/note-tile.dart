// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, file_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:notepad/hive/notes_model.dart';
import 'package:notepad/provider/homescreen_provider.dart';
import 'package:notepad/screens/reading_screen.dart';
import 'package:notepad/utils/utils.dart';
import 'package:notepad/widgets/custom-popup-btn.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NoteTile extends StatelessWidget {
  final NotesModel note;
  final Map<String, Color> categoryColor;

  NoteTile({required this.note, required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final provider = Provider.of<HomescreenProvider>(context, listen: false);
    bool titleRight = note.isTitleRightSided ?? false;
    bool notesRight = note.isNotesRightSided ?? false;

    return Card(
      color: categoryColor[note.category],
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: InkWell(
          onTap: () {
            provider.isMultiSelection
                ? provider.toggleSelection(note)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadingScreen(
                              noteModel: note,
                            )));
          },
          onLongPress: provider.isSearchEnable
              ? () {}
              : () {
                  if (!provider.isMultiSelection) {
                    provider.setMultiSelection(true);
                  }
                  provider.toggleSelection(note);
                },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: titleRight
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          note.title ?? '',
                          textDirection: getTextDirection(note.title ?? ''),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        )),
                        Spacer(),
                        CustomPopUpMenu(note: note),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: notesRight
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Text(
                          note.notes,
                          textDirection: getTextDirection(note.notes),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          note.category ?? '',
                          style: TextStyle(fontWeight: FontWeight.w600
                              // color: categoryColor[note.category ?? ''],
                              ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          note.date != null
                              ? DateFormat.yMMMMEEEEd().format(note.date!)
                              : '',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // Divider(),
                  ],
                ),
                Consumer<HomescreenProvider>(builder: (context, provider, _) {
                  return Visibility(
                      visible: provider.isMultiSelection,
                      child: Icon(
                        provider.selectedItem.contains(note)
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 20,
                        // color: Colors.amber,
                      ));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
