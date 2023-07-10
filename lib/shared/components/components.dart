import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget textfield(
    {required String lablestr,
    GestureTapCallback? onTab,
    bool visabilty = false,
    FormFieldValidator<String>? validator,
    IconData? prefix,
    IconData? suffix,
    TextEditingController? controller,
    TextInputType keyboard = TextInputType.text,
    double lablesize = 20,
    double radius = 20,
    FontWeight weight = FontWeight.bold}) {
  return TextFormField(
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      suffixIcon: Icon(suffix),
      labelText: lablestr,
      labelStyle: TextStyle(fontSize: lablesize, fontWeight: weight),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    keyboardType: keyboard,
    controller: controller,
    validator: validator,
    obscureText: visabilty,
    onTap: onTab,
  );
}

Widget container(Map model, context,
    {double offset1 = 0.0,
    double offset2 = 0.0,
    double bluRadius = 0,
    double borderRadius = 20,
    double radius = 15,
    double radiusCircle = 20,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.bold}) {
  return Dismissible(
    key: Key(model ['id'].toString()),
    child: Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(offset: Offset(offset1, offset2), blurRadius: bluRadius)
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: radiusCircle,
            child: Text(model['time']),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model['task_name'],
                  style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                ),
                Text(
                  model['date'],
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<AppCubit>(context).newTasks=[];
                  BlocProvider.of<AppCubit>(context).doneTasks=[];
                  BlocProvider.of<AppCubit>(context).archivedTasks=[];
                  AppCubit.get(context)
                      .upDateDatabase( states: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box_rounded,
                  color: Colors.green,
                )),
          ),
          Expanded(
            child: TextButton(
                onPressed: () {
                  BlocProvider.of<AppCubit>(context).newTasks=[];
                  BlocProvider.of<AppCubit>(context).doneTasks=[];
                  BlocProvider.of<AppCubit>(context).archivedTasks=[];
                  AppCubit.get(context)
                      .upDateDatabase( states: 'archived', id: model['id']);
                },
                child: Text('بعدين'),
          ),)
        ],
      ),
    ),
    onDismissed: (direction){
     AppCubit.get(context).deleteDatabase(id: model['id']);
    },
  );
}

//Widget buildScreen(List<Map> tasks){
//   return
// }