import 'package:content_example/Screens/content_overlaypanel.dart';
import 'package:flutter/material.dart';
import 'package:content_example/Screens/content_detail.dart';
import 'package:provider/provider.dart';
import 'package:content_example/Services/storage_service.dart';

class ContentDisplay extends StatefulWidget {
  const ContentDisplay({Key? key, required this.title, this.itemID = ''})
      : super(key: key);

  final String title;
  final String itemID;
  @override
  State<ContentDisplay> createState() => _ContentDisplayState();
}

class _ContentDisplayState extends State<ContentDisplay> {
  bool _collapsed = false;
  @override
  void initState() {
    final storageservice = Provider.of<StorageService>(context, listen: false);
    storageservice.setReference(widget.title, itemID: widget.itemID);
    _collapsed = (storageservice.getCurrentItems() == null)
        ? true
        : (storageservice.getCurrentItems()!.length > 1)
            ? false
            : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          const ContentDetail(),
          ContentOverlayPanel(initialcollapsed: _collapsed),
        ],
      ),
    );
  }
}
