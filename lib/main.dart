import 'package:e_ticaret_app2/db/dbHelper.dart';
import 'package:e_ticaret_app2/screens/UrunListesi.dart';
import 'package:flutter/material.dart';
import 'package:e_ticaret_app2/models/Urun.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Urun> urunler = new List<Urun>();
    DbHelper dbHelper = new DbHelper();
    dbHelper.dbOlustur().then((database) => {});
    
    // Urun urun1 = new Urun("Televizyon", "4K smart TV", 12000);
    // Urun urun2 = new Urun("Telefon", "128 Gb akıllı telefon", 8000);
    // Urun urun3 = new Urun("Kulaklık", "7.1 sanal surround ses efekti", 1200);
    // Urun urun4 = new Urun("Saat", "Duvar saati", 150);
    // dbHelper.ekle(urun1);
    // dbHelper.ekle(urun2);
    // dbHelper.ekle(urun3);
    // dbHelper.ekle(urun4);


    return MaterialApp(
      title: "eticaret2",
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnaSayfaState();
  }
}

class AnaSayfaState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("E-Ticaret Uygulaması",style: TextStyle(color:  Colors.amber,fontSize: 27),textAlign: TextAlign.center,),
      ),
      body: UrunListesi(),
    );
  }

}


