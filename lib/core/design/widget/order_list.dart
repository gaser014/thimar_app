part  of'../../../view/home/bloc.dart'; // Assuming the library name is 'my_library'
class _OrderList extends StatelessWidget {
  final _OrderModel model;
  const _OrderList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int price = 0;
    for (var item in model.items) {
      price += item.price;
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          // margin: const EdgeInsets.only(bottom: 9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xfF000000).withOpacity(.02),
                blurRadius: 17,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طلب #${model.id}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    model.date,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff9C9C9C),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: 92,
                        height: 25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color:
                                      const Color(0xff61B80C).withOpacity(.06),
                                  width: .5,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    model.items[index].image,
                                  ),
                                  fit: BoxFit.scaleDown,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          itemCount:
                              model.items.length < 3 ? model.items.length : 3,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      model.items.length <= 3
                          ? const SizedBox()
                          : Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color(0xffEDF5E6),
                              ),
                              child: Text(
                                '+${model.items.length - 3}',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: 95,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Color(model.state.background).withOpacity(.2),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        model.state.state,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(model.state.fontColor),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$price ر.س',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
