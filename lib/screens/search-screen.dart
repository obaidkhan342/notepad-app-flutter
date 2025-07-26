// ignore_for_file: annotate_overrides, unused_local_variable, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:notepad/provider/homescreen_provider.dart';
import 'package:notepad/widgets/note-card.dart';
import 'package:notepad/widgets/note-tile.dart';
import 'package:provider/provider.dart';
import '../provider/addnotes_provider.dart';
import '../provider/pref-provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final homeProvider = Provider.of<HomescreenProvider>(context);
    final prefProvider = Provider.of<PrefProvider>(context, listen: true);
    final adnProvider = Provider.of<AddNotesProvider>(context);
    final notesList = homeProvider.notesBox.values.toList();

    final filterNotes = notesList.where((note) {
      final title = note.title?.toLowerCase() ?? '';
      final content = note.notes.toLowerCase();
      return title.contains(query.toLowerCase()) || content.contains(query);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search in notes',
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: query.isEmpty
          ?null
          : filterNotes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty.png',
                        width: mq.width * 0.2,
                        height: mq.height * 0.2,
                      ),
                      Text('No Result found for "${query}"'),
                    ],
                  ),
                )
              : prefProvider.isNotesCard
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: filterNotes.length,
                      itemBuilder: (BuildContext context, index) {
                        final note = filterNotes[index];
                        return NoteCard(
                            note: note,
                            categoryColor: adnProvider.categoryColor);
                      })
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: filterNotes.length,
                      itemBuilder: (context, index) {
                        final note = filterNotes[index];
                        return NoteTile(
                            note: note,
                            categoryColor: adnProvider.categoryColor);
                      }),
    );
  }
}
