import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc {
  
  static final ScansBloc _singleton=new ScansBloc._internal();
  
  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener los scans de la base de datos
    obtenerScans();

  }

  final _scansStreamController=StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream=>_scansStreamController.stream;

  dispose(){
    _scansStreamController?.close();
  }


  obtenerScans() async {
    _scansStreamController.sink.add(await DBprovider.db.getTodosLosScans());
  }

  borrarScan( int id) async {
    await DBprovider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBprovider.db.deleteAll();
    obtenerScans();
  }

  agregarScan(ScanModel scan) async {
    await DBprovider.db.nuevoScan(scan);
    obtenerScans();
  }


}