


import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
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
    final path=join(documentsDirectory.path,'Scans.db');


    return await openDatabase(
        path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db,version) async {
          await db.execute(
            'CREATE TABLE sacans('
              'id INTEGER PRIMARY KEY,'
              'tipo TEXT,'
              'valor TEXT'
            ')'
          );
        }
      );

  }


  //Crear registros en la db
  nuevoScanRaw(ScanModel nuevoScan) async {
    
    final db=await database;
    final res= await db.rawInsert(
      "INSERT INTO sacans (id,tipo,valor) "
      "VALUES (${nuevoScan.id},${nuevoScan.tipo},${nuevoScan.valor})"
    );

    return res;

  }


  nuevoScan(ScanModel nuevoScan) async {
    final db=await database;
    final res=await db.insert('scans', nuevoScan.toJson());
    return res; 
  }


  // SELECT - Obtener informacion
  Future<ScanModel> getScanid(int id) async {
    final db = await database;
    final res=await db.query('sacans',where: 'id=?',whereArgs: [id]);
    return res.isNotEmpty?ScanModel.fromJson(res.first):null;
  }

  Future<List<ScanModel>> getTodosLosScans() async {
    final db=await database;
    final res=await db.query('scans');
    List<ScanModel> list=res.isNotEmpty
                          ?res.map((scan)=>ScanModel.fromJson(scan)).toList():[];
    return list;
  }


   Future<List<ScanModel>> getTodosLosScansXtipo(String tipo) async {
    final db=await database;
    final res=await db.rawQuery("SELECT * FROM scans WHERE tipo='$tipo' ");
    List<ScanModel> list=res.isNotEmpty
                          ?res.map((scan)=>ScanModel.fromJson(scan)).toList():[];
    return list;
  }


}