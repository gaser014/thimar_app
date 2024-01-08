part of 'bloc.dart';

class ProductsData {
  late final List<ProductModel> list;

  // late final Links links;
  // late final Meta meta;
  late final int userCartCount;
  late final double minPrice, maxPrice;

  ProductsData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => ProductModel.fromJson(e))
        .toList();
    // links = Links.fromJson(json['links']);
    // meta = Meta.fromJson(json['meta']);

    userCartCount = json['user_cart_count'] ?? 0;
    minPrice = double.tryParse(json['min_price'].toString()) ?? 0;
    maxPrice = double.tryParse(json['max_price'].toString()) ?? 0;
  }
}

class ProductModel {
  late final int categoryId, id, priceBeforeDiscount;
  late final String title;
  late final String description;
  late final String code;
  late final double price;
  late double totalPrice;
  late final int discount;
  late final int amount;
  late int count;
  late final int isActive;
  late bool isFavorite;
  late final Unit unit;
  late final List<Images> images;
  late final String mainImage;
  late final String createdAt;
  late Widget favoriteIcon;

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] ?? 0;
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    code = json['code'] ?? '';
    priceBeforeDiscount = json['price_before_discount'] ?? 0;
    price = double.tryParse(json['price'].toStringAsFixed(2)) ?? 0;
    discount = (json['discount'] * 100).toInt();
    amount = double.tryParse(json['amount'].toString())?.toInt() ?? 0;
    count = json['count'] ?? 1;
    totalPrice = getTotalPrice(count);
    isActive = json['is_active'] ?? 0;
    isFavorite = json['is_favorite'] ?? false;
    favoriteIcon = getFavoriteIcon(isFavorite);
    unit = Unit.fromJson(json['unit'] ?? {});
    images =
        List.from(json['images'] ?? []).map((e) => Images.fromJson(e)).toList();
    mainImage = json['main_image'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  double getTotalPrice(int count) {
    return double.tryParse((price * count).toStringAsFixed(2)) ?? 0;
  }

  // Widget get favoriteWid
  Widget getFavoriteIcon(bool isFavorite) => AppBarIcon(
        path: DataAssets.iconFavorite,
        isFavorite: isFavorite,
      );
}

class Unit {
  late final int id;
  late final String name, type, createdAt, updatedAt;

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    type = json['type'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    url = json['url'] ?? '';
  }
}
