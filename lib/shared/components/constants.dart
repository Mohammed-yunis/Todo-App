import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/screen1.dart';
import 'package:todo/screen2.dart';
import 'package:todo/screen3.dart';


List<String> appbar = ["Tasks", "Done", "Archived"];
List<Widget> screen = const [Screen1(), Screen2(), Screen3()];



//------------------------------------------------

var index = 0;
var formkey = GlobalKey<FormState>();
var taskController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
var scaffoldKey = GlobalKey<ScaffoldState>();
var listKey = GlobalKey();
var scrollController=ScrollController();

//------------------------------------------------
bool show=false;
Database? database;