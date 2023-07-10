

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/cubit/states.dart';
import 'shared/cubit/cubit.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {
      if(BlocProvider.of<AppCubit>(context).newTasks.isEmpty){
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.table_rows_rounded,
                  size: 50,
                  color: Colors.grey,
                ),
                Text('No Tasks${appbar[index]} yet! Pleas Enter Some Tasks',style: const TextStyle(color: Colors.grey),)
              ],
            ));
      }
      print(BlocProvider.of<AppCubit>(context).newTasks.length);
      },
      builder: (BuildContext context, Object? state) {
        return  ConditionalBuilder(
          condition:BlocProvider.of<AppCubit>(context).newTasks.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: container(BlocProvider.of<AppCubit>(context).newTasks[index], radiusCircle: 35,context),
                ),
                itemCount: BlocProvider.of<AppCubit>(context).newTasks.length); },
          fallback: (BuildContext context) { return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.table_rows_rounded,
                    size: 50,
                    color: Colors.grey,
                  ),
                  Text('No Tasks${appbar[index]} yet! Pleas Enter Some Tasks',style: const TextStyle(color: Colors.grey),)
                ],
              )); },

        );
      },
    );
  }

}


