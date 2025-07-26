// ignore_for_file: unused_import, unused_element, prefer_const_constructors, unnecessary_string_interpolations, avoid_print, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../hive/notes_model.dart';

Future<void> generateAndSaveNotesPdf({
  required bool downloadOnly,
  required NotesModel noteModel,
  required BuildContext context,
}) async {
  try {
    final pdf = pw.Document();

    // Here is MCQS Page
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(10),
        build: (context) => [
          pw.Column(children: [
            _buildPdf(noteModel),
          ])
        ],
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final filePath =
        "${outputDir.path}/notes${DateTime.now().millisecondsSinceEpoch}.pdf";

    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    if (!downloadOnly) {
      if (Platform.isAndroid || Platform.isIOS) {
        await Share.shareXFiles([XFile(file.path)], text: 'note pdf');
      } else {
        Share.share('Download your note PDF from: $filePath');
      }
    }
  } catch (e) {
    print('Error generating PDF: $e');
    rethrow;
  }
}

pw.Widget _buildPdf(NotesModel noteModel) {
  return pw.Padding(
      padding: const pw.EdgeInsets.all(15.0),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text(
                noteModel.category!,
              ),
              pw.SizedBox(width: 10),
              pw.Text(noteModel.date != null
                  ? '${DateFormat.yMd().format(noteModel.date!)}'
                  : ''),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            noteModel.title.toString(),
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            noteModel.notes.toString(),
            style: pw.TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ));
}
