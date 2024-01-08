part of 'bloc.dart';

class ReviewData {
  late final List<ReviewModel> list;

  ReviewData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => ReviewModel.fromJson(e))
        .toList();
  }
}

class ReviewModel {
  late final double value;
  late final String comment, clientName, clientImage;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    value = double.tryParse(json['value'].toStringAsFixed(2)) ?? 0;
    comment = json['comment'] ?? '';
    clientName = json['client_name'] ?? '';
    clientImage = json['client_image'];
  }
}
