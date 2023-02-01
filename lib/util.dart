import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List>generatePdf(final PdfPageFormat format)async{

  final doc=pw.Document(
    title: "NAGAIR Ticket",
  );

  final logoImage=pw.MemoryImage((await rootBundle.load("assets/nag-air-logo.png")).buffer.asUint8List());

  final footerImage=pw.MemoryImage((await rootBundle.load("assets/nag-air-logo.png")).buffer.asUint8List());

  //final font=await rootBundle.load("assets/opensence.ttf");
  //final ttf=pw.TtfFont(font);
  final pageTheme=await _myPageTheme(format);

  doc.addPage(
      pw.MultiPage(
    pageTheme: pageTheme,
        header: (final contex)=>pw.Image(


          alignment: pw.Alignment.topCenter,
            logoImage,
          fit: pw.BoxFit.contain,
          width: 220,
          height: 250

        ),
        footer: (final context)=>pw.Image(
          footerImage,
          alignment: pw.Alignment.bottomRight,
          fit: pw.BoxFit.scaleDown,
          width: 300,
          height: 100
        ),
        build: (final contex)=>[
          pw.Container(

            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(20),
              border: pw.Border.all(width: 2)

            ),
            margin: pw.EdgeInsets.symmetric(horizontal: 50),
            width: 300,
            padding: const pw.EdgeInsets.only(left: 30,bottom: 20,right: 30,top: 20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children:[
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                 pw.Column(
                   children: [
                     pw.Text("DLH",style: pw.TextStyle(
                       fontSize: 30,
                       fontWeight: pw.FontWeight.bold,


                     )),




                     pw.Text("Delhi",style: pw.TextStyle(
                       fontSize: 20,
                       //fontWeight: pw.FontWeight.bold,

                     )),

                   ]
                 ),

                     pw.Column(
                       children: [
                         pw.Row(
                           children: [

                           ]
                         )
                       ]
                     ),



                     pw.Column(
                       children: [
                         pw.Text("LND",style: pw.TextStyle(
                           fontSize: 30,
                           fontWeight: pw.FontWeight.bold,
                         )
                         ),

                         pw.Text("London",style: pw.TextStyle(
                           fontSize: 20,
                           //fontWeight: pw.FontWeight.bold,
                         )
                         ),


                       ]
                     )

                ])

              ]
            )
          )
        ]
  )
  );

  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat) async{

  final logoImage=pw.MemoryImage((await rootBundle.load("assets/nag-air-logo.png")).buffer.asUint8List());
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 20,vertical: 21
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context)=>pw.FullPage(
      ignoreMargins: true,
      child: pw.Watermark(
        angle: 20,
        child: pw.Opacity(
          opacity: 0.5,
          child: pw.Image(
            alignment: pw.Alignment.center,
            logoImage,
            fit: pw.BoxFit.cover
          )
        )
      )
    )
  );

}


Future<void>saveAsFile(
final BuildContext context,
final LayoutCallback build,
final PdfPageFormat pageFormat,
)async{
  final bytes= await build(pageFormat);
  final appDocDir=await getApplicationDocumentsDirectory();
  final appDocPath=appDocDir.path;
  final file=File("$appDocPath/Document.pdf");
  print("${file.path}");
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Printed")));
}

void showSharedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("shared")));
}

