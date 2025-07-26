// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../screens/add_note.dart';

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNote()));
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.description_outlined,
                size: 40,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Add Notes",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14
              ))
            ],
          ),
        ),
      ),
    );
  }
}
