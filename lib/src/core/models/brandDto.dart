class BrandDto {

  int id;
  String name;

  BrandDto.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
  }

  BrandDto(this.id, this.name);
}

class Brands {
  List<BrandDto> list = List();

  Brands();

  Brands.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final brand = BrandDto.fromJson(item);
      list.add(brand);
    });
  }
}