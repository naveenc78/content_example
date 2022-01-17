import 'dart:ffi';

class Category {
  late String name;
  late String displayname;
  late String folder;
  late String icon;
  late List<Category> _subcategories;

  Category(
      {required this.name,
      required this.displayname,
      required this.folder,
      required this.icon});

  void ordercategories(
      {required Map<String, dynamic> categories, required List<String> order}) {
    if (categories.isEmpty) return;
    //check if order of all elements is provided
    if (categories.length == order.length) {
      _subcategories = [
        for (int i = 0; i < order.length; i++) categories[order[i]]
      ];
      return;
    }

    _subcategories = [for (var category in categories.values) category];
  }
}
