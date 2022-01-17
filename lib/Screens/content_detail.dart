import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:content_example/Services/storage_service.dart';
import 'package:content_example/Screens/html_view.dart';
import 'package:content_example/Screens/pdf_view.dart';

class ContentDetail extends StatelessWidget {
  const ContentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This gets the current state of contents and also tells Flutter
    // to rebuild this widget when content notifies listeners (in other words,
    // when it changes).
    var contents = context.watch<StorageService>();
    double width = MediaQuery.of(context).size.width *
        ((MediaQuery.of(context).size.width <= 600) ? 0.95 : 0.7);
    double height = MediaQuery.of(context).size.height * 0.9;

    return (contents.getCurrentItem() == null)
        ? (contents.isOperationInProgress())
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage('assets/images/cmc.png')))))
        : (contents.getCurrentDownloadUrl().isEmpty)
            ? (contents.getCurrentItem()!.name.endsWith('.pdf') == true)
                ? FutureBuilder(
                    future: contents.getCurrentItem()!.getData(),
                    builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("${snapshot.error}",
                                  style:
                                      Theme.of(context).textTheme.bodyText1));
                        } else {
                          return Pdfview(
                              name: contents.getCurrentItem()!.name,
                              source: snapshot.data!,
                              width: width,
                              height: height);
                        }
                      }

                      return const Center(child: CircularProgressIndicator());
                    })
                : Center(
                    child: IframeView(
                        source: contents.composeDownloadUrl(),
                        width: width,
                        height: height))
            : Center(
                // child: Row(children: <Widget>[
                // SizedBox(width: 0.1.sw),
                //Expanded(
                child: IframeView(
                    source: contents.composeDownloadUrl(),
                    width: width,
                    height: height));
    //]));
  }
}

//                            return Expanded(
//         child: SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       controller: _scrollController,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(4.0, 20.0, 20.0, 10.0),
// //        child: ConstrainedBox(
// //          constraints:
// //              BoxConstraints(maxHeight: widgetheight, maxWidth: widgetwidth),
// //          child: Column(
// //            mainAxisAlignment: MainAxisAlignment.start,
// //            crossAxisAlignment: CrossAxisAlignment.stretch,
// //            children: <Widget>[
// //              Flexible(

// Sample template widgets for future use
                 // return showdetail(
                  //     contents.getCurrentItem()!.name,
                  //     '',
                  //     snapshot.data!,
                  //     MediaQuery.of(context).size.height,
                  //     MediaQuery.of(context).size.shortestSide * 0.6,
                  //     contents.logger);
 
  // widget to show the detail view
  // Widget showdetail(String itemname, String itemurl, Uint8List itemdata,
  //     double widgetheight, double widgetwidth, Logger log) {
  //   log.d('Item: ' + itemname);
  //   log.d('ItemURL: ' + itemurl);

  //   if (itemname.endsWith('.pdf')) {
  //     final pdfController = PdfController(
  //       document: PdfDocument.openData(itemdata),
  //     );

  //     return SizedBox(
  //         width: widgetwidth,
  //         height: widgetheight,
  //         child: Expanded(
  //             child: ListView(
  //                 shrinkWrap: true,
  //                 children: [PdfView(controller: pdfController)])));
  //   }

  //   return const Center(child: Text('Ooo - really close. Stay Tuned!'));
    //for all other files return this
   
  // }

