// ignore_for_file: file_names, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad/hive/notes_model.dart';
import 'package:notepad/screens/reading_screen.dart';
import 'package:notepad/utils/utils.dart';
import 'package:notepad/widgets/custom-popup-btn.dart';
import 'package:provider/provider.dart';
import '../provider/homescreen_provider.dart';

class NoteCard extends StatelessWidget {
  final NotesModel note;
  final Map<String, Color> categoryColor;
  const NoteCard({required this.note, required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final provider = Provider.of<HomescreenProvider>(context, listen: false);
    final noteRight = note.isNotesRightSided ?? false;
    final titleRight = note.isTitleRightSided ?? false;

    return Card(
      color: categoryColor[note.category],
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
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
              height: mq.size.height * 0.20,
              width: mq.size.width * 0.40,
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: titleRight
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text(
                                note.title ?? '',
                                textDirection:
                                    getTextDirection(note.title ?? ''),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )),
                          // Spacer(),
                          Flexible(
                            child: CustomPopUpMenu(
                              note: note,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: noteRight
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            note.notes,
                            textDirection: getTextDirection(note.notes),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ))
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            note.date != null
                                ? DateFormat.yMEd().format(note.date!)
                                : '',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
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
                        ));
                  })
                ],
              ),
            )),
      ),
    );
  }
}
