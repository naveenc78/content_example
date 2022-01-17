import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'dart:typed_data';

class Pdfview extends StatefulWidget {
  final Uint8List source;
  final String name;
  final double width;
  final double height;

  const Pdfview(
      {Key? key,
      required this.source,
      required this.name,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  _PdfviewState createState() => _PdfviewState();
}

const double minScale = 1.0;
const double defScale = 1.8;
const double maxScale = 1.8;

class _PdfviewState extends State<Pdfview> {
  static const int _initialPage = 1;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  late PdfController _pdfController;
  late PhotoViewController controller;

  int calls = 0;

  void onController(PhotoViewControllerValue value) {
    setState(() {
      calls += 1;
    });
  }

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openData(widget.source),
      initialPage: _initialPage,
      viewportFraction: 1.0,
    );
    controller = PhotoViewController(initialScale: defScale)
      ..outputStateStream.listen(onController);

    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.navigate_before),
                        onPressed: (_actualPageNumber == _initialPage)
                            ? () {}
                            : () {
                                _pdfController.previousPage(
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 100),
                                );
                              },
                        tooltip: 'Previous Page',
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_out),
                        onPressed: () {
                          controller.scale = controller.scale! - 0.1;
                        },
                        tooltip: 'Zooom Out',
                      ),
                      Text(
                        'Pages $_actualPageNumber/$_allPagesCount',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_in),
                        onPressed: () {
                          controller.scale = controller.scale! + 0.1;
                        },
                        tooltip: 'Zoom In',
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: (_actualPageNumber == _allPagesCount)
                            ? () {}
                            : () {
                                _pdfController.nextPage(
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 100),
                                );
                              },
                        tooltip: 'Next Page',
                      ),
                    ],
                  ),
                  //),
                ],
              ),
            ),
            Expanded(
              child: PdfView(
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                documentLoader:
                    const Center(child: CircularProgressIndicator()),
                pageLoader: const Center(child: CircularProgressIndicator()),
                controller: _pdfController,
                onDocumentLoaded: (document) {
                  setState(() {
                    _allPagesCount = document.pagesCount;
                  });
                },
                onPageChanged: (page) {
                  setState(() {
                    _actualPageNumber = page;
                  });
                },
                pageBuilder: (
                  Future<PdfPageImage> pageImage,
                  int index,
                  PdfDocument document,
                ) =>
                    PhotoViewGalleryPageOptions(
                  imageProvider:
                      PdfPageImageProvider(pageImage, index, document.id),
                  basePosition: Alignment.topCenter,
                  controller: controller,
                  minScale: PhotoViewComputedScale.contained * minScale,
                  maxScale: PhotoViewComputedScale.covered * 1.4,
                  initialScale: PhotoViewComputedScale.contained * 1.2,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: '${document.id}-$index'),
                ),
              ),
              //],
              //),
              //),
              //),
            ),
          ],
        ),
      ),
    );
  }
}
