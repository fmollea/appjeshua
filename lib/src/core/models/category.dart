class Category {
  int id;
  String name;
  String slug;
  String image;

  Category.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    slug = snapshot['slug'];
    image = snapshot['image'] == null ? '' : snapshot['image'];
  }
 
  Category(this.id, this.name, this.slug, this.image);
}

class Categories {
  List<Category> list = List();

  Categories();

  Categories.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final product = Category.fromJson(item);
      list.add(product);
    });
  }
}