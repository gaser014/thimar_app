part of '../../bloc.dart';

class _OrderPage extends StatefulWidget {
  _OrderPage({Key? key}) : super(key: key);

  @override
  State<_OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<_OrderPage> {
  final model = _OrderModel().list();
  bool isLoading = true;
@override
  void initState() {
  _delay();
    super.initState();
}
_delay()async{
  await Future.delayed(Duration(seconds: 2));
  setState(() {
    isLoading=false;
  });
}
  @override
  Widget build(BuildContext context) {
    print("model is ${model[5]}");
    print("*"*50);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading?
        Center(child: CircularProgressIndicator())
            :Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("طلباتي",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  )),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print(model[index].id);
                    return
                      _OrderList(
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
