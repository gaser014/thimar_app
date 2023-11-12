part of 'bloc.dart';

class CardData {
  late final List<CardModel> list;
  late final double totalPriceBeforeDiscount;
  late final double totalDiscount;
  late final double totalPriceWithVat;
  late final double deliveryCost;
  late final double freeDeliveryPrice;
  late final double vat;
  late final Widget vatWidget;
  late final int isVip;
  late final int vipDiscountPercentage;
  late final int minVipPrice;
  late final String? vipMessage;
  late final String status;

  CardData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => CardModel.fromJson(e))
        .toList();
    totalPriceBeforeDiscount = json['total_price_before_discount']*1.0;
    totalDiscount = json['total_discount']*-1.0;
    totalPriceWithVat = json['total_price_with_vat']*1.0;
    deliveryCost = json['delivery_cost']*1.0;
    freeDeliveryPrice = json['free_delivery_price']*1.0;
    vat = (json['vat'] * (totalPriceBeforeDiscount - totalDiscount));
    vatWidget = vat > 0
        ? const SizedBox()
        : Padding(
            padding: EdgeInsets.all(9.0.r),
            child: Row(
              children: [
                Text(
                  DataString.vat,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4C8613),
                  ),
                ),
                const Spacer(),
                Text(
                  ' ${vat.toInt()} ر.س',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4C8613),
                  ),
                ),
              ],
            ),
          );

    isVip = json['is_vip'];
    vipDiscountPercentage = json['vip_discount_percentage'];
    minVipPrice = json['min_vip_price'];
    vipMessage = json['vip_message'] ?? '';
    status = json['status'];
  }
}

class CardModel {
  late final int id;
  late final String title;
  late final String image;
  late final int amount;
  late final int priceBeforeDiscount;
  late final int discount;
  late final double price;
  late final int remainingAmount;

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    amount = json['amount'];
    priceBeforeDiscount = json['price_before_discount'];
    discount = json['discount'];
    price = json['price']*amount*1.0;
    remainingAmount = json['remaining_amount'];
  }
}

class Coupon {
  late final String status;
  late final String message;

  Coupon.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
