

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../../../../core/design/unit/app_string.dart';
import 'model.dart';
import 'order_list.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final model = OrderModel().list();
  bool isLoading = true;
@override
  void initState() {
  _delay();
    super.initState();
}
_delay()async{
  await Future.delayed(const Duration(seconds: 2));
  setState(() {
    isLoading=false;
  });
}
  @override
  Widget build(BuildContext context) {
    debugPrint("model is ${model[5]}");
    debugPrint("*"*50);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading?
        const Center(child: CircularProgressIndicator())
            :Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(DataString.myOrders.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  )),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    debugPrint(model[index].id);
                    return
                      OrderList(
                      model: model[index],
                    );

                  },
                  itemCount: model.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
