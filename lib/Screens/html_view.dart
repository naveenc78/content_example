//ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class IframeView extends StatefulWidget {
  final String source;
  final double width;
  final double height;

  const IframeView(
      {Key? key,
      required this.source,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  _IframeViewState createState() => _IframeViewState();
}

class _IframeViewState extends State<IframeView> {
  // Widget _iframeWidget;
  late html.IFrameElement _iframeElement;

  @override
  void initState() {
    super.initState();
    _iframeElement = html.IFrameElement();
    _iframeElement.src = widget.source;
    _iframeElement.style.border = 'none';
    _iframeElement.style.width = '100%';
    _iframeElement.style.height = '100%';

    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.source, //use source as registered key to ensure uniqueness
      (int viewId) => _iframeElement,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.source);
    return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.all(5.0),
        child: HtmlElementView(
          key: UniqueKey(),
          viewType: widget.source,
        ));
  }
}
