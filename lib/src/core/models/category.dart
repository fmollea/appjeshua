class Category {
  int id;
  String name;
  String status;
  String image;
  String createdAt;
  String updatedAt;

  Category.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    status = snapshot['status'];
    image = snapshot['image'];
    createdAt = snapshot['created_at'];
    updatedAt = snapshot['updated_at'];
  }

  Category(this.id, this.name, this.status, this.image, this.createdAt,
      this.updatedAt);
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
