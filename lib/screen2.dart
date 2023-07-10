import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return  ConditionalBuilder(
          condition:BlocProvider.of<AppCubit>(context).doneTasks.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.separated(
                controller: scrollController,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: container(BlocProvider.of<AppCubit>(context).doneTasks[index], radiusCircle: 35,context),
                ),
                separatorBuilder: (context, index) { return Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                );
                },
                itemCount: BlocProvider.of<AppCubit>(context).doneTasks.length); },
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


