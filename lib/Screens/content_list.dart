import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:content_example/Services/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ContentList extends StatelessWidget {
  const ContentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.bodyText2;
    var selecteditemStyle = Theme.of(context).textTheme.bodyText1;
    // This gets the current state of contents and also tells Flutter
    // to rebuild this widget when content notifies listeners (in other words,
    // when it changes).
    var contents = context.watch<StorageService>();
    List<Reference>? curItems = contents.getCurrentItems();
    if (curItems == null) {
      return Center(
          child: Text('Coming Soon.\n Stay Tuned!', style: itemNameStyle));
    }

    int selectedindex = contents.getSelectedIndex();

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: curItems.length,
        itemBuilder: (context, index) => PointerInterceptor(
                child: Card(
              color: Colors.transparent,
              elevation: 20.0,
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                  onTap: () {
                    contents.setSelectedItem(index);
                  },

                  // leading: (MediaQuery.of(context).size.width <= 500)
                  //     ? null
                  //     : (selectedindex == index)
                  //         ? const Icon(Icons.notes_rounded)
                  //         : null,
                  title: (selectedindex == index)
                      ? Text(
                          curItems[index].name.split('.')[0],
                          style: selecteditemStyle,
                          textAlign: TextAlign.left,
                        )
                      : Text(curItems[index].name.split('.')[0],
                          style: itemNameStyle, textAlign: TextAlign.left),
                  selected: (selectedindex == index)),
            )));
  }
}
