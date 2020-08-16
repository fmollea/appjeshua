class ModelDto {
  int id;
  String name;

  ModelDto.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
  }

  ModelDto(this.id, this.name);
}

class Models {
  List<ModelDto> list = List();

  Models();

  Models.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final brand = ModelDto.fromJson(item);
      list.add(brand);
    });
  }
}
