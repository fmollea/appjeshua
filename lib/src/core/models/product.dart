class Product {
  int id;
  String name;
  String sku;
  String description;
  String path;
  String stock;
  String price;
  String price2;
  String price3;
  String price4;
  int cantMayor2;
  int cantMayor3;
  int cantMayor4;
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
    price2 = setPrice(snapshot['price_2']);
    price3 = setPrice(snapshot['price_3']);
    price4 = setPrice(snapshot['price_4']);
    cantMayor2 = setMayoreo(snapshot['mayoreo_2']);
    cantMayor3 = setMayoreo(snapshot['mayoreo_3']);
    cantMayor4 = setMayoreo(snapshot['mayoreo_4']);
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

  String selectPrice(int quantity) {
    if (cantMayor4 != 0 && cantMayor4 <= quantity) return price4;
    if (cantMayor3 != 0 && cantMayor3 <= quantity) return price3;
    if (cantMayor2 != 0 && cantMayor2 <= quantity) return price2;
    return price;
  }   

  bool existPricebyMayor() => cantMayor4 != 0 || cantMayor3 != 0 || cantMayor2 != 0;
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
  
  if (price is int) {
    return price.toString();
  }

  if (price is double) {
    return price.toStringAsFixed(2);
  }

  if (price is String) {
    var newPrice = double.parse(price);
    return newPrice.toStringAsFixed(2);
  }

  return '0';
}

int setMayoreo(dynamic mayoreo) {
  if(mayoreo == null) return 0;

  if (mayoreo is int) {
    return mayoreo;
  }

  if (mayoreo is double) {
    return mayoreo.toInt();
  }
  
  if (mayoreo is String) {
    var newPrice = int.parse(mayoreo);
    return newPrice;
  }
  return 0;
}
