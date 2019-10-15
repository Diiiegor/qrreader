


import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBprovider{

  static Database _database;
  static final DBprovider db=DBprovider._();

  DBprovider._();


  Future<Database>get database async{

    if(_database!=null){
      return _database;
    }
    else{
      _database=await initDB();

      return _database;
    }


  }

  initDB() async{

    Directory documentsDirectory= await getApplicationDocumentsDirectory();
    final path=join();

  }


}