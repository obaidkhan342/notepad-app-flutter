// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/addnotes_provider.dart';

class EmptyCategory extends StatelessWidget {
  final String ctg;
  final int? index;
  const EmptyCategory({required this.ctg, this.index});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddNotesProvider>(context);
    final mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/emptyctg.png',
              width: mq.width * 0.2,
              height: mq.height * 0.2,
            ),
            Text('No file found in $ctg Category'),
            Text('Add new one')
          ],
        ),
      ),
    );
  }
}
