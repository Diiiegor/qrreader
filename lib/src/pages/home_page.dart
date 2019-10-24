import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';


class HomePage extends StatefulWidget {
   HomePage({Key key}) : super(key: key);
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginactual=0;
  final scansBloc=new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Scaner'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: ()=>scansBloc.borrarScanTodos(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.filter_center_focus),
          onPressed: _scannqr,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _cargarPegina(paginactual),
        bottomNavigationBar: _crearBottomNavigationBar(),
      ),
    );
  }

  _scannqr() async {

    //http://ieo.com.co/
    //geo:5.05483704611272,-75.49949152434624

    String futureString='http://ieo.com.co/';

    /*try{
      futureString= await new QRCodeReader().scan();
    }catch(e){
      print(e.toString());
    }
    */

    if(futureString!= null){
      final scan=ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);
    }

  }


  Widget _cargarPegina(int pagina) {
    switch (pagina) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: paginactual,
      onTap: (int index) {
        setState(() {
         this.paginactual=index; 
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones'))
      ],
    );
  }
}
