import 'package:flutter/material.dart';
import 'package:content_example/Screens/content_list.dart';

class ContentSideBar extends StatelessWidget {
  const ContentSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.shortestSide <= 600)
        ? (MediaQuery.of(context).size.height * 0.6)
        : (MediaQuery.of(context).size.shortestSide * 0.6);
    double width = (MediaQuery.of(context).size.shortestSide <= 600)
        ? size * 0.6
        : size * 0.4;

    return Container(
        width: width,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[100],
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: size * 0.95),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Expanded(
                    child: ContentList(),
                  ),
                ],
              ),
            )));
  }
}
