import 'dart:core';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class FirestoreService extends ChangeNotifier {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Map<String, dynamic>? _entitycontent;

  FirestoreService() {
    _entitycontent = null;
  }

  // getcategories
  void getEntityContent(String entity) {
    _firestore
        .collection("Contents")
        .where('entity_id' == entity)
        .get()
        .then((querySnapshot) => {
              _entitycontent = null,
              if (querySnapshot.docs.isNotEmpty)
                _entitycontent = querySnapshot.docs[0].data(),
            });
  }

  // get ordered categories
  void getOrderedCategories() {
    if (_entitycontent == null) return;
  }
  //set reference - you can set this any number of times - this will refresh its
  // children and notify listeners
  // void setReference(String base) async {
  //   logger.d("SetReference called with: " + base);
  //   //check if same ref
  //   if (_base == base) {
  //     logger.d("Reference already at " + base);
  //     return; // reference previously set
  //   }

  //   _base = base;
  //   _currentref = _storage!.ref(base);
  //   resetcurrentcontent();
  //   if (_currentref == null) {
  //     logger.d("Storage refernece not found: " + base);
  //     notifyListeners();
  //     return;
  //   }

  //   //get list of all contents
  //   _currentcontents = await list();

  //   if (_currentcontents == null) {
  //     logger.d("Found no contents");
  //     notifyListeners();
  //     return;
  //   }

  //   if (_currentcontents!.prefixes.isEmpty) {
  //     logger.d("Found no directories");
  //     if (_currentcontents!.items.isEmpty) {
  //       logger.d("Found no items");
  //       notifyListeners();
  //       return;
  //     }
  //   }

  //   logger.d("SerReference found contents");
  //   _currentcategories = _currentcontents!.prefixes;
  //   if (_currentcategories != null) {
  //     for (int i = 0; i < _currentcategories!.length; i++) {
  //       logger.d("Found directory: " + _currentcategories![i].fullPath);
  //     }
  //   }

  //   _currentitems = _currentcontents!.items;
  //   if (_currentitems == null) {
  //     logger.d("Found no items");
  //     notifyListeners();
  //     return;
  //   }

  //   for (int i = 0; i < _currentitems!.length; i++) {
  //     logger.d("Found item: " + _currentitems![i].fullPath);
  //   }

  //   _currentitem = _currentitems![0];
  //   _currentdownloadurl = '';
  //   if (_currentitem != null) {
  //     logger.d("Selected item: " + _currentitem!.fullPath);
  //   }

  //   notifyListeners();
  // }

}
