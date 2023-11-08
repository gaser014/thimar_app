part of 'bloc.dart';
class ProductsEvents{}
class ProductEvent extends ProductsEvents{
  int? id;
  ProductType type;
String? keyword;
  ProductEvent({ this.type=ProductType.custom,this.keyword,this.id});
}
