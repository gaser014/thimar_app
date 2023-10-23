import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/view/home/bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, state) => SafeArea(
        child: Scaffold(
          body: state is HomeBottomNavState ? state.body : bloc.items[0],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: const Color(0xffAED489),
            selectedItemColor: Colors.white,
            items: bloc.list(),
            onTap: (index) {
              bloc.add(HomeEvent(index: index));
            },
            currentIndex: state is HomeBottomNavState ? state.index : 0,
          ),
        ),
      ),
    );
  }
}
