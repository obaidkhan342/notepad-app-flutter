// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(), // or NeverScrollableScrollPhysics()
      shrinkWrap: true,
      itemCount: 3, // Your actual item count
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.folder_outlined, size: 30),
          title: Text("Category $index", 
              style: TextStyle(fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}