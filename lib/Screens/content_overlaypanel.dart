import 'package:flutter/material.dart';
import 'package:collapsible/collapsible.dart';
import 'package:content_example/Screens/content_sidebar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ContentOverlayPanel extends StatefulWidget {
  const ContentOverlayPanel({Key? key, required this.initialcollapsed})
      : super(key: key);

  final bool initialcollapsed;
  @override
  State<ContentOverlayPanel> createState() => _ContentOverlayPanelState();
}

class _ContentOverlayPanelState extends State<ContentOverlayPanel> {
  // this boolean controls the collapsible widget
  bool _collapsed = false;

  @override
  void initState() {
    _collapsed = widget.initialcollapsed;
    super.initState();
  }

  void _toggleCollapsible() {
    setState(() {
      _collapsed = !_collapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Collapsible(
          child: const ContentSideBar(),
          collapsed: _collapsed,
          axis: CollapsibleAxis.both,
          maintainAnimation: true,
          maintainState: true,
          fade: true,
          duration: const Duration(milliseconds: 1000),
        ),
        PointerInterceptor(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.05),
              maximumSize: Size(MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.1),
              elevation: 5.0,
              primary:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2))),
          onPressed: _toggleCollapsible,
          child: Icon(_collapsed ? Icons.close_fullscreen : Icons.open_in_full),
        )),
      ],
    );
  }
}
