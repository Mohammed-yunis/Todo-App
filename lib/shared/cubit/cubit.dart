// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  void setIndex(value){
    index=value;
    emit(BottomNavBarState());
  }
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];

  void createdatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
            'create table Tasks(id integer primary key,task_name text,time text,date text,statue text)')
            .then((value) => print('table created'))
            .catchError((error) =>
            print('error appear on creating table it is $error'));
      },
      onOpen: (database) {
        getDatabase(database);

        print('database is opened');
      },
    ).then((value) {
      database= value;
      emit(CreateDatabaseState());
    });
  }

  insertDatabase(
      {required String taskName, required String time, required String date}) async {
    await database!.transaction((txn) {
      return txn.rawInsert(
          'insert into Tasks(task_name,time,date,statue) values("$taskName","$time","$date","New")');
    })
        .then((value) {

          print('$value inserted successfully');
          emit(InsertDatabaseState());
          getDatabase(database);

        })
        .catchError((error) {
      print('error appear on creating table it is $error');
    });
  }

  void getDatabase(database) {

    database.rawQuery('SELECT * FROM Tasks').then((value) {

        value.forEach((element) {
         if(element['statue']=='New'){

           newTasks.add(element);
         }
         else if(element['statue']=='done'){

           doneTasks.add(element);
         }
         else{

           archivedTasks.add(element);
         }
       });
        emit(GetDatabaseState());
      });

  }

  void upDateDatabase({required String states,required int id})async {
    database!.rawUpdate('update Tasks set statue = ? where id = ?',[states,id]).then((value){

      getDatabase(database);
      emit(UpDateDatabaseState());
    });
  }

  void deleteDatabase({required int id})async {
    database!.rawDelete('delete from Tasks where id = ?',[id]).then((value){
      newTasks=[];
      doneTasks=[];
      archivedTasks=[];
      getDatabase(database);
      emit(DeleteDatabaseState());
    });
  }
}