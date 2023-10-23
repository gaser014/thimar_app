import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/feature/cities/bloc.dart';

import 'model.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({Key? key}) : super(key: key);

  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}

class _CitiesSheetState extends State<CitiesSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height:double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            DataString.country,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),

          Expanded(
            child: BlocBuilder<CitiesBloc,CitiesState>(

              builder: (context, state) {
                if (state is CitiesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CitiesSuccessState) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => _Item(
                  model: state.model.list[index],
                    ),
                    itemCount: state.model.list.length,
                  );
                } else if(state is CitiesFailedState)  {
                  return
 Center(child:  Text(state.message,
            style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                ),),);
                }else{
                  return const SizedBox();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final CitiesModel model;

  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, model);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).primaryColor.withOpacity(.1)),
        child: Center(
          child: Text(
            model.name,
          ),
        ),
      ),
    );
  }
}
