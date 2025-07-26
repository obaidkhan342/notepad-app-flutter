// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';

import 'category_list.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Simple",
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    Text("Notes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Spacer(),
                    Icon(Icons.dark_mode),
                  ],
                ),
                SizedBox(height: 5),
                ListTile(
                  leading: const Icon(
                    Icons.note_outlined,
                    size: 30,
                  ),
                  title: Text("Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.folder_copy_outlined,
                    size: 30,
                  ),
                  title: Text("Uncategorized",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: 5),
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    size: 30,
                  ),
                  title: Text("Trash",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Divider(),
                CategoryList(),
                Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.category,
                    size: 30,
                  ),
                  title: Text("Manage Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.backup,
                    size: 30,
                  ),
                  title: Text("Backup / Restore",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  title: Text("Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
