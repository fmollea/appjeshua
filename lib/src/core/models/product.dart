class Product {
  int id;
  String name;
  String sku;
  String description;
  String path;
  String stock;
  String price;
  String priceWithOutIva;
  String slug;
  String department;
  String slugCategory;
  bool isAvaiable;
  bool isFav;

  Product.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    sku = snapshot['sku'];
    description = snapshot['description'];
    slugCategory = snapshot['categories'][0]['slug'];
    path = snapshot['coverImage'] == null ? '' : snapshot['coverImage'];
    price = setPrice(snapshot['price']);
    priceWithOutIva = setPrice(snapshot['priceWithoutIva']);
    department = snapshot['department'];
    slug = snapshot['slug'];
    stock = snapshot['stock'] == null ? '0' : snapshot['stock'].toString();
    isFav = snapshot['isFav'] == null ? false : snapshot['isFav'];
    isAvaiable = int.parse(stock) > 0;
  }

   Product.fromJsonOrderDetail(Map<String, dynamic> snapshot) {
    id = snapshot['product_id'];
    name = snapshot['product_name'];
    sku = snapshot['sku'];
    path = snapshot['cover'] == null ? '' : snapshot['cover'];
    price = snapshot['unit_cost'];
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "current_price": price,
  };     
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

String setPrice(dynamic price) {
  if(price == null) return '0';

  if (price is String) {
    var newPrice = double.parse(price);
    return newPrice.toStringAsFixed(2);
  }

  if (price is int) {
    return price.toString();
  }

  if (price is double) {
    return price.toStringAsFixed(2);
  }

  return '0';
}
