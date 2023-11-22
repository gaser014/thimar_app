part of 'bloc.dart';
class ProductsEvents{}
class ProductEvent extends ProductsEvents{
 final int? id;
 final ProductType type;
 final String? keyword;
  ProductEvent({ this.type=ProductType.custom,this.keyword,this.id});
}
