part of'bloc.dart';
class ReviewData {

  late final List<ReviewModel> list;


  ReviewData.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=>ReviewModel.fromJson(e)).toList();

  }

}

class ReviewModel {

  late final double value;
  late final String comment;
  late final String clientName;
  late final String clientImage;

  ReviewModel.fromJson(Map<String, dynamic> json){
    value = json['value']*1.0??0.0;
    comment = json['comment']??'';
    clientName = json['client_name']??'';
    clientImage = json['client_image'];
  }

}

