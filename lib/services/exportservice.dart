import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ExportService {
  Map sortmap(Map mapitem, String opFilename) {
    var sortedmap = new Map();
    if (opFilename == 'members') {
      sortedmap['mem_id'] = mapitem['mem_id'];
      sortedmap['name'] = mapitem['name'];
    }
    if (opFilename == 'books') {
      sortedmap['bookId'] = mapitem['bookId'];
      sortedmap['bookName'] = mapitem['bookName'];
      sortedmap['bookauthor'] = mapitem['bookauthor'];
    }
    mapitem.forEach(
      (key, value) {
        if (key == 'mem_id' ||
            key == 'name' ||
            key == 'bookId' ||
            key == 'bookName' ||
            key == 'bookAuthor') {
          print("key dummy : $key");
          return;
        }
        sortedmap[key] = value;
      },
    );
    print("sorted map : $sortedmap");
    return sortedmap;
  }

  Future createExcel(String opFilename,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> contentList) async {
//Create an Excel document.
    int colindex = 1;
    int rowindex = 2;
    //Creating a workbook.
    final Workbook workbook = Workbook();
    Style globalStyle = workbook.styles.add('style');
    globalStyle.bold = true;
    final Worksheet sheet = workbook.worksheets[0];

    sortmap(contentList.first.data(), opFilename).forEach((key, value) {
      sheet.getRangeByIndex(1, colindex).cellStyle = globalStyle;
      sheet.getRangeByIndex(1, colindex).setValue(key);
      colindex += 1;
    });
    colindex = 1;
    for (var element in contentList) {
      colindex = 1;
      sortmap(element.data(), opFilename).forEach(
        (key, value) {
          if (value.runtimeType == Timestamp)
            sheet.getRangeByIndex(rowindex, colindex).setValue(value.toDate());
          else
            sheet.getRangeByIndex(rowindex, colindex).setValue(value);
          colindex += 1;
        },
      );
      rowindex += 1;
    }
    // contentList.forEach((element) {
    //   sortmap(element.data());
    // });
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String filename = '$path/$opFilename.xlsx';
    final File file = File(filename);

    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(filename);
  }
}
