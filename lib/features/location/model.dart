class LocationData {
  late final List<LocationModel> list;

  LocationData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? '')
        .map((e) => LocationModel.fromJson(e))
        .toList();
    list.sort((a, b) => a.isDefault ? -1 : 1);
  }
}

class LocationModel {
  late final int id;
  late final String type;
  late final double lat;
  late final double lng;
  late final String location;
  late final String description;
  late final bool isDefault;
  late final String phone;

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? '';
    lat = double.tryParse(json['lat'].toString()) ?? 0.0;
    lng = double.tryParse(json['lng'].toString()) ?? 0.0;
    location = json['location'].toString().split('،،')[0];
    description = json['description'] ?? '';
    isDefault = json['is_default'] ?? false;
    phone = json['phone'] ?? '';
  }
}
