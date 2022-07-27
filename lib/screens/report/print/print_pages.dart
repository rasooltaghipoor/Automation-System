import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'data.dart';
import 'pages/report.dart';
import 'pages/my_doc.dart';

const examples = <Page>[
  Page('پرینت من', 'my_doc.dart', generateMyResume),
  Page('REPORT', 'report.dart', generateReport),
];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, CustomData data);

class Page {
  const Page(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
