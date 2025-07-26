// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_field, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:notepad/provider/addnotes_provider.dart';
import 'package:notepad/provider/homescreen_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final addPro = Provider.of<AddNotesProvider>(context);
    return Consumer<HomescreenProvider>(builder: (context, value, _) {
      return SizedBox(
        height: mq.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListTile(
                tileColor:
                    value.selectedCategory == "All" ? Colors.amber : null,
                onTap: () {
                  value.setFilterCategory("All");
                  addPro.setCurrentIndex(0);
                  Navigator.of(context).pop(); // Close bottom sheet
                },
                title: Text('All Notes'),
                leading: Icon(Icons.sticky_note_2_outlined),
              ),
              ListTile(
                tileColor:
                    value.selectedCategory == "Work" ? Colors.amber : null,
                onTap: () {
                  addPro.setCurrentIndex(0);
                  value.setFilterCategory("Work");
                  Navigator.of(context).pop();
                },
                title: Text('Work'),
                leading: Icon(Icons.work),
              ),
              ListTile(
                tileColor:
                    value.selectedCategory == "Personal" ? Colors.amber : null,
                onTap: () {
                  addPro.setCurrentIndex(1);
                  value.setFilterCategory("Personal");
                  Navigator.of(context).pop();
                },
                title: Text('Personal'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                tileColor:
                    value.selectedCategory == "Idea" ? Colors.amber : null,
                onTap: () {
                  Navigator.of(context).pop();
                  value.setFilterCategory("Idea");
                  addPro.setCurrentIndex(2);
                },
                title: Text('Idea'),
                leading: Icon(Icons.psychology),
              ),
            ],
          ),
        ),
      );
    });
  }
}
