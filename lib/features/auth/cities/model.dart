class CitiesData {
  late final List<CitiesModel> list;

  CitiesData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => CitiesModel.fromJson(e))
        .toList();
  }
}

class CitiesModel {
  late final String id, name;

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
  }
}
