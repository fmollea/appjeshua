class Product {
  int id;
  String name;
  String sku;
  String description;
  String path;
  String stock;
  String price;
  String slug;
  bool isAvaiable;
  bool isFav;

  Product.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    sku = snapshot['sku'];
    description = snapshot['description'];
    path = snapshot['coverImage'];
    price = snapshot['precio'] == null ? '0' : snapshot['precio'];
    slug = snapshot['slug'];
    stock = snapshot['stock'] == null ? '0' : snapshot['stock'];
    isFav = snapshot['is_fav'] == null ? false : snapshot['is_fav'];
    isAvaiable = int.parse(stock) > 0;
  }

  Product(
      this.id,
      this.name,
      this.sku,
      this.description,
      this.stock,
      this.price,
      this.path,
      this.slug,
      this.isAvaiable,
      this.isFav);
}

class Products {
  List<Product> list = List();

  Products();

  Products.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final product = Product.fromJson(item);
      list.add(product);
    });
  }
}
