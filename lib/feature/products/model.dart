part of'bloc.dart';
class ProductsData {
  late final List<ProductModel> list;

  // late final Links links;
  // late final Meta meta;
  late final int userCartCount;
  late final int maxPrice;
  late final double minPrice;

  ProductsData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => ProductModel.fromJson(e))
        .toList();
    // links = Links.fromJson(json['links']);
    // meta = Meta.fromJson(json['meta']);

    userCartCount = json['user_cart_count']??0;
    maxPrice = json['max_price']??0;
    minPrice = json['min_price']??0;
  }
}

class ProductModel {
  late final int categoryId;
  late final int id;
  late final String title;
  late final String description;
  late final String code;
  late final int priceBeforeDiscount;
  late final double price;
  late  double totalPrice;
  late final int discount;
  late final int amount;
late  int count;
  late final int isActive;
  late  bool isFavorite;
  late final Unit unit;
  late final List<Images> images;
  late final String mainImage;
  late final String createdAt;
late  Widget favoriteIcon ;

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    code = json['code'];
    priceBeforeDiscount = json['price_before_discount'];
    price = json['price']*1.0;
    discount = (json['discount'] * 100).toInt();
    amount = json['amount'];
    count = json['count']??1;
    totalPrice = getTotalPrice(count);
    isActive = json['is_active'];
    isFavorite = json['is_favorite']??false;
    favoriteIcon=  getFavoriteIcon(isFavorite);
    unit = Unit.fromJson(json['unit']);
    images = List.from(json['images']??[]).map((e) => Images.fromJson(e)).toList();
    mainImage = json['main_image'];
    createdAt = json['created_at'];
  }
  double getTotalPrice(int count)=>price*count;
  // Widget get favoriteWid
Widget getFavoriteIcon(bool isFavorite)=>AppBarIcon(
  path: DataAssets.iconFavorite,
  isFavorite:  isFavorite,
);

}

class Unit {
  late final int id;
  late final String name;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

// class Links {
//
//   late final String first;
//   late final String last;
//   late final Null prev;
//   late final Null next;
//
//   Links.fromJson(Map<String, dynamic> json){
//     first = json['first']??'';
//     last = json['last']??'';
//     prev = null;
//     next = null;
//   }
//
// }

// class Meta {
//
//   late final int currentPage;
//   late final int from;
//   late final int lastPage;
//   late final List<Links> links;
//   late final String path;
//   late final int perPage;
//   late final int to;
//   late final int total;
//
//   Meta.fromJson(Map<String, dynamic> json){
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }
//
// }
