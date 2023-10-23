class CategoriesData {

  late final List<CategoriesModel> list;



  CategoriesData.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=>CategoriesModel.fromJson(e)).toList();

  }

}

class CategoriesModel {

  late final int id;
  late final String name;
  late final String description;
  late final String image;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    id = json['id']??'';
    name = json['name']??'';
    description = json['description']??'';
    image = json['media']??'';
  }

}

