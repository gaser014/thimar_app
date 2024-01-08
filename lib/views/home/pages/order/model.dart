import 'dart:math';

import '../../../../core/design/unit/app_assets.dart';
import '../../../../core/design/unit/app_string.dart';

class OrderModel {
  late String id;
  late final StateOrder state;
  final _list = StateOrder()._listOfState();
  late final List<Items> items;
  late final String date =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  OrderModel();
  OrderModel.map({
    required this.id,
    required this.state,
    required this.items,
  });

  List<OrderModel> list() => [
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
          id: Random().nextInt(10000).toString(),
          state: _list[Random().nextInt(_list.length)],
          items: Items().listItems,
        ),
        OrderModel.map(
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
