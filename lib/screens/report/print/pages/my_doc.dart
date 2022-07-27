/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateMyResume(
    PdfPageFormat format, CustomData data) async {
  final doc = pw.Document(title: 'داکیومنت من', author: 'David PHAM-VAN');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/profile.jpg')).buffer.asUint8List(),
  );

  final netImage = await networkImage('https://www.nfet.net/nfet.jpg');

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: <pw.Widget>[
                    pw.Container(
                      padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: <pw.Widget>[
                          pw.Text('عباسعلی رونالدو',
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold)),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 10)),
                          pw.Text('خفن تایپیست',
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                      fontWeight: pw.FontWeight.bold,
                                      color: green)),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 20)),
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: <pw.Widget>[
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text('نیشابور خراسان رضوی'),
                                  pw.Text('جنب ایران'),
                                  pw.Text('ایران'),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text('+1 403-721-6898'),
                                  _UrlText('p.charlesbois@yahoo.com',
                                      'mailto:p.charlesbois@yahoo.com'),
                                  _UrlText('wholeprices.ca',
                                      'https://wholeprices.ca'),
                                ],
                              ),
                              pw.Padding(padding: pw.EdgeInsets.zero)
                            ],
                          ),
                        ],
                      ),
                    ),
                    _Category(title: 'سوابق کاری'),
                    _Block(
                        title: 'راننده اتوبوس',
                        icon: const pw.IconData(0xe530)),
                    _Block(title: 'لوله کش', icon: const pw.IconData(0xe30d)),
                    _Block(
                        title: 'دکتر پوست و زیبایی',
                        icon: const pw.IconData(0xe3f3)),
                    _Block(
                        title: 'پرورش کره خر', icon: const pw.IconData(0xf0cf)),
                    _Block(
                        title: 'ریییس جمهور', icon: const pw.IconData(0xe0ca)),
                    pw.SizedBox(height: 20),
                    _Category(title: 'سوابق آموزشی'),
                    _Block(title: 'کارشناس سواری مردم'),
                    _Block(title: 'ارشد گیاه شناسی'),
                    pw.SizedBox(height: 20),
                    _Category(title: 'جدول کار'),
                    pw.Container(
                      margin: const pw.EdgeInsets.fromLTRB(22, 5, 22, 5),
                      child: pw.Table.fromTextArray(
                        headerStyle: const pw.TextStyle(fontSize: 10),
                        headers: <dynamic>[
                          'مهارت',
                          'مستحبات',
                          'نماز و اقامه',
                          'بسیج'
                        ],
                        cellAlignment: pw.Alignment.center,
                        cellStyle: const pw.TextStyle(fontSize: 8),
                        data: <List<dynamic>>[
                          <dynamic>['50', 'عالی', 'بد نیست', 'عالی'],
                        ],
                      ),
                    ),
                    pw.Image(netImage, width: 200, height: 200),
                  ],
                ),
              ),
            ),
            pw.Partition(
              width: sep,
              child: pw.Column(
                children: [
                  pw.Container(
                    height: pageTheme.pageFormat.availableHeight,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.ClipOval(
                          child: pw.Container(
                            width: 100,
                            height: 100,
                            color: lightGreen,
                            child: pw.Image(profileImage),
                          ),
                        ),
                        pw.Column(children: <pw.Widget>[
                          _Percent(size: 60, value: .7, title: pw.Text('Word')),
                          _Percent(
                              size: 60, value: .4, title: pw.Text('Excel')),
                        ]),
                        pw.BarcodeWidget(
                          data: 'Parnella Charlesbois',
                          width: 60,
                          height: 60,
                          barcode: pw.Barcode.qrCode(),
                          drawText: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/Icons/File.svg');
  var persianFont = pw.Font.ttf(await rootBundle.load('assets/fonts/sans.ttf'));

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: persianFont,
      bold: persianFont,
      icons: persianFont,
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    this.icon,
  });

  final String title;

  final pw.IconData? icon;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
                if (icon != null) pw.Icon(icon!, color: lightGreen, size: 18),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(
                      'صنعت بازی سازی یکی از مهمترین و پردرآمدترین صنایع در جهان امروز است و توانسته مخاطبی به بزرگی 2 میلیارد از جمعیت جهان را به خود اختصاص دهد، بازی سازی نه تنها در سرگرمی تاثیر گذاشته بلکه امروزه در فرهنگ سازی و شبکه سازی اجتماعی نیز تاثیر بسزایی گذاشته است.'),
                ]),
          ),
        ]);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class _Percent extends pw.StatelessWidget {
  _Percent({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;

  final double value;

  final pw.Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  pw.Widget build(pw.Context context) {
    final widgets = <pw.Widget>[
      pw.Container(
        width: size,
        height: size,
        child: pw.Stack(
          alignment: pw.Alignment.center,
          fit: pw.StackFit.expand,
          children: <pw.Widget>[
            pw.Center(
              child: pw.Text(
                '${(value * 100).round().toInt()}%',
                textScaleFactor: fontSize,
              ),
            ),
            pw.CircularProgressIndicator(
              value: value,
              backgroundColor: backgroundColor,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ],
        ),
      )
    ];

    widgets.add(title);

    return pw.Column(children: widgets);
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}
