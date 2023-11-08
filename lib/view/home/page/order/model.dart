part of '../../bloc.dart';
class _OrderModel {
  late String id;
  late final StateOrder state;
  final _list = StateOrder()._listOfState();
  late final List<Items> items;
  late final String date="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";


  _OrderModel();

  _OrderModel.map({
    required this.id,
    required this.state,
    required this.items,
  });

  List<_OrderModel> list() => [
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        _OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
      ];
}

class StateOrder {
  late final String state;
  late final int background;
  late final int fontColor;

  StateOrder();

  StateOrder.map({
    required this.background,
    required this.fontColor,
    required this.state,
  });

  List<StateOrder> _listOfState() => [
        StateOrder.map(
            background: 0xffEDF5E6,
            fontColor: 0xff4C8613,
            state: DataString.stateRepair),
        StateOrder.map(
          background: 0xffEAFFD5,
          fontColor: 0xff4C8613,
          state: DataString.stateAccept,
        ),
        StateOrder.map(
          background: 0xffE6F5F0,
          fontColor: 0xff2D9E78,
          state: DataString.stateDelivery,
        ),
      ];
}

class Items {
  late final String image;
  late final int price;
  final random = Random();
  final randomImage = Random();
  final randomPrice = Random();
  late List<Items> listItems;

  Items() {
    int z = random.nextInt(8) + 1;
    listItems = [];
    String image;
    for (int i = 0; i < z; i++) {
      image = mapOfItems.keys.elementAt(
        randomImage.nextInt(mapOfItems.length),
      );

      listItems.add(
        Items.map(
          price: mapOfItems[image]!,
          image: image,
        ),
      );
    }
  }

  Items.map({required this.image, required this.price});

  Map<String, int> mapOfItems = {
    DataAssets.networkCarrot: 5,
    DataAssets.networkMango: 40,
    DataAssets.networkTomato: 2,
    DataAssets.networkWaterLemon: 15,
    DataAssets.networkApple: 10,
  };
}
// class OrderCurrent {
//   late final List<OrderCurrentModel> list;
//
//   OrderCurrent.fromJson(Map<String, dynamic> json) {
//     list = List.from(json['data'])
//         .map((e) => OrderCurrentModel.fromJson(e))
//         .toList();
//   }
// }

// class OrderCurrentModel {
//   late final int id;
//   late final String status;
//   late final String date;
//   late final String time;
//   late final double orderPrice;
//   late final double deliveryPrice;
//   late final double totalPrice;
//   late final String clientName;
//   late final String phone;
//   late final String location;
//   late final String deliveryPayer;
//   late final List<Products> products;
//   late final String payType;
//   late final String note;
//   late final int isVip;
//   late final int vipDiscountPercentage;
//
//   OrderCurrentModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     status = json['status'];
//     date = json['date'];
//     time = json['time'];
//     orderPrice = json['order_price'];
//     deliveryPrice = json['delivery_price'];
//     totalPrice = json['total_price'];
//     clientName = json['client_name'];
//     phone = json['phone'];
//     location = json['location'];
//     deliveryPayer = json['delivery_payer'];
//     products =
//         List.from(json['products']).map((e) => Products.fromJson(e)).toList();
//     payType = json['pay_type'];
//     note = json['note'];
//     isVip = json['is_vip'];
//     vipDiscountPercentage = json['vip_discount_percentage'];
//   }
// }
//
// class Products {
//   late final String name;
//   late final String url;
//
//   Products.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     url = json['url'];
//   }
// }