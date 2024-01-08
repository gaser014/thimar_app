import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/unit/app_string.dart';

class CardData {
  late List<CardModel> list;
  late final Widget vatWidget;
  late double totalPriceBeforeDiscount, totalPriceWithVat, totalDiscount;
  late final double deliveryCost, freeDeliveryPrice, vat;
  late final String vipMessage, status;
  late final int isVip, vipDiscountPercentage, minVipPrice;

  CardData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => CardModel.fromJson(e))
        .toList();
    totalPriceBeforeDiscount = double.tryParse(
            json['total_price_before_discount'].toStringAsFixed(2)) ??
        0;
    totalDiscount =
        double.tryParse(json['total_discount'].toStringAsFixed(2)) ?? 0;
    totalPriceWithVat =
        double.tryParse(json['total_price_with_vat'].toStringAsFixed(2)) ?? 0;
    deliveryCost =
        double.tryParse(json['delivery_cost'].toStringAsFixed(2)) ?? 0;
    freeDeliveryPrice =
        double.tryParse(json['free_delivery_price'].toStringAsFixed(2)) ?? 0;
    vat = (double.tryParse(json['vat'].toStringAsFixed(2)) ??
        0 * (totalPriceBeforeDiscount - totalDiscount));
    vatWidget = vat > 0
        ? const SizedBox()
        : Padding(
            padding: EdgeInsets.all(9.0.r),
            child: Row(
              children: [
                Text(
                  DataString.vat.tr(),
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
    isVip = json['is_vip'] ?? 1;
    vipDiscountPercentage = json['vip_discount_percentage'] ?? 1;
    minVipPrice = json['min_vip_price'] ?? 1;
    vipMessage = json['vip_message'] ?? DataString.vipMessage;
    status = json['status'] ?? '';
  }

  deleteCard(int index) {
    totalPriceBeforeDiscount = totalPriceBeforeDiscount -
        (list[index].priceBeforeDiscount * list[index].amount);
    totalPriceWithVat = totalPriceWithVat - list[index].totalPriceWithVat;
    totalDiscount = totalPriceBeforeDiscount - totalPriceWithVat;
    list.removeAt(index);
  }

  upDateCard(int index, int amount) {
    totalPriceBeforeDiscount =
        totalPriceBeforeDiscount + (list[index].priceBeforeDiscount * amount);
    totalPriceWithVat = totalPriceWithVat + (list[index].price * amount);
    totalDiscount = totalPriceBeforeDiscount - totalPriceWithVat;
    list[index].amount += amount;
    list[index].totalPriceWithVat = list[index].price * list[index].amount;
  }
}

class CardModel {
  late final String title, image;
  late final int id;
  late int amount;
  late double priceBeforeDiscount, discount, price, totalPriceWithVat;
  late final int remainingAmount;

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    image = json['image'] ?? '';
    amount = json['amount'] ?? 0;
    priceBeforeDiscount =
        double.tryParse(json['price_before_discount'].toStringAsFixed(2)) ?? 0;
    discount = double.tryParse(json['discount'].toStringAsFixed(2)) ?? 0;
    price = double.tryParse(json['price'].toStringAsFixed(2)) ?? 0;
    totalPriceWithVat = price * amount;
    remainingAmount = json['remaining_amount'] ?? 0;
  }
}

class Coupon {
  late final String status, message;

  Coupon.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    message = json['message'] ?? '';
  }
}
