part of 'bloc.dart';
class SliderData {
  late final List<SliderModel> list;


  SliderData.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=>SliderModel.fromJson(e)).toList();

  }

}

class SliderModel {
  late final int id;
  late final String media;

  SliderModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['media'] = media;
    return _data;
  }
}