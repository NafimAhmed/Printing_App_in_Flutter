import 'package:create_pdf3/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFPage extends StatefulWidget {
  const PDFPage({Key? key}) : super(key: key);

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {

  PrintingInfo? printingInfo;



  @override
  void initState(){
    super.initState();
    _init();

  }

  Future<void> _init()async{

    final info=await Printing.info();
    setState((){
      printingInfo=info;
    });

  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug=true;
    final actions=<PdfPreviewAction>[
      //if(!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveAsFile)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF APP"),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,


      )
    );
  }
}
