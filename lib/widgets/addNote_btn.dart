// ignore_for_file: file_names, unused_import, unused_element, dead_code, unused_label, unnecessary_import, prefer_const_constructors, avoid_function_literals_in_foreach_calls, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:notepad/utils/dialog-box.dart';
import 'package:provider/provider.dart';
import '../provider/homescreen_provider.dart';
import '../screens/add_note.dart';

class AddNoteBtn extends StatefulWidget {
  const AddNoteBtn({super.key});

  @override
  State<AddNoteBtn> createState() => _AddNoteBtnState();
}

class _AddNoteBtnState extends State<AddNoteBtn> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomescreenProvider>(
      builder: (context, provider, _) {
        return provider.isMultiSelection
            ? FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  // Smooth UI: show dialog after current frame
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showMyAnimatedDialog(
                      context: context,
                      title: 'Confirm',
                      content: 'Do you want to delete selected item(s)?',
                      actionText: 'Yes',
                      onActionPressed: (value) {
                        if (value) {
                          provider.selectedItem.forEach((note) {
                            provider.delete(note);
                          });
                          provider.clearSelection();
                        }
                      },
                    );
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height : 4),
                    Icon(Icons.delete),
                    SizedBox(height: 4),
                    Text('Delete', style: TextStyle(fontSize: 12)),
                  ],
                ),
              )
            : FloatingActionButton(
                shape: const CircleBorder(),
                foregroundColor: Colors.amber,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddNote()),
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              );
      },
    );
  }
}
