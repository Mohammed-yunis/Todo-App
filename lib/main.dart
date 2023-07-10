// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';
import 'package:todo/shared/style/blocObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (BuildContext context) => AppCubit()..createdatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(appbar[index]),
                centerTitle: true,
              ),
              drawer: SafeArea(
                child: Drawer(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(width: 2, color: Colors.black)),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task), label: "Task"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task_alt), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: "Archived")
                ],
                onTap: (value) {
                  cubit.setIndex(value);
                },
                currentIndex: index,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.black,
                showUnselectedLabels: false,
              ),
              body:screen[index] ,


              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  if(show)
                    {

                      if (formkey.currentState!.validate()) {
                        if (scrollController.hasClients) {
                          scrollController.jumpTo(
                              scrollController.position
                                  .maxScrollExtent);
                        }
                        Navigator.pop(context);
                        BlocProvider.of<AppCubit>(context).newTasks = [];
                        BlocProvider.of<AppCubit>(context).doneTasks = [];
                        BlocProvider.of<AppCubit>(context).archivedTasks = [];
                        cubit.insertDatabase(
                            taskName: taskController.text,
                            time: timeController.text,
                            date: dateController.text);
                      }
                      taskController.clear();
                      timeController.clear();
                      dateController.clear();
                      show=false;
                    }
                  else {
                    scaffoldKey.currentState!.showBottomSheet(
                          (context1) =>
                          Container(
                            padding: const EdgeInsets.all(18),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                              color: Colors.grey,
                            ),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  textfield(
                                      lablestr: "Task",
                                      radius: 10,
                                      lablesize: 25,
                                      prefix: Icons.add_task_outlined,
                                      keyboard: TextInputType.text,
                                      controller: taskController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This Field Is Required";
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  textfield(
                                      lablestr: "Time",
                                      radius: 10,
                                      lablesize: 25,
                                      prefix: Icons.watch_later_outlined,
                                      keyboard: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This Field Is Required";
                                        }
                                        return null;
                                      },
                                      controller: timeController,
                                      onTab: () {
                                        showTimePicker(
                                            context: context1,
                                            initialTime: TimeOfDay.now())
                                            .then((value) =>
                                        timeController.text =
                                            value!.format(context1).toString());
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  textfield(
                                      lablestr: "Date",
                                      radius: 10,
                                      lablesize: 25,
                                      prefix: Icons.calendar_month_outlined,
                                      keyboard: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This Field Is Required";
                                        }
                                        return null;
                                      },
                                      controller: dateController,
                                      onTab: () {
                                        showDatePicker(
                                            context: context1,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2028))
                                            .then((value) =>
                                        dateController.text =
                                            DateFormat.yMMMd()
                                                .format(value!)
                                                .toString());
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),

                                ],
                              ),
                            ),
                          ),
                    );
                    show=true;
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
