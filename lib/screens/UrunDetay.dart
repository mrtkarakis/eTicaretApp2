import 'package:e_ticaret_app2/db/dbHelper.dart';
import 'package:e_ticaret_app2/main.dart';
import 'package:e_ticaret_app2/models/Urun.dart';
import 'package:flutter/material.dart';

class UrunDetay extends StatefulWidget {
  Urun urun;
  UrunDetay(this.urun);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UrunDetayState(urun);
  }
}

DbHelper dbHelper = new DbHelper();
enum Secenek { sil, guncelle }

class UrunDetayState extends State {
  Urun urun;
  UrunDetayState(this.urun);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(urun.ad),
        actions: [
          PopupMenuButton<Secenek>(
              onSelected: islemSec,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Secenek>>[
                    PopupMenuItem(
                      value: Secenek.sil,
                      child: Text("Ürünü sil"),
                    ),
                    PopupMenuItem(
                        value: Secenek.guncelle, child: Text("Ürünü Güncelle")),
                  ])
        ],
      ),
      body: Center(
        child: Column(
            children: [
              SizedBox(height: 9),
              ListTile(

                leading: Icon(
                  Icons.shop,
                  size: 32,
                ),
                title: Text(urun.ad, style: TextStyle(fontSize: 26)),
                subtitle: Text(urun.aciklama, style: TextStyle(fontSize: 16)),
                trailing: Text(
                  "${urun.fiyat} ₺",
                  style: TextStyle(fontSize: 27),
                ),
              ),
              Center(
                child: ButtonBar(
                  children: [
                    TextButton(
                        onPressed: (){
                          AlertDialog alertDialog = new AlertDialog(
                            title: Text("İşlem başarılı"),
                            content: Text("${urun.ad} sepete eklendi"),
                          );
                          showDialog(context: context, builder: (_)=> alertDialog);
                        },
                      child: Center(
                        widthFactor: 3, // yazıyı yerşeltirme 1 sol 2 dol orta arası 3 orta
                        heightFactor: 0,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.add_shopping_cart,size: 30,color: Colors.green,),
                              ),

                              TextSpan(
                                children: [
                                  WidgetSpan(child: Text("Sepete Ekle",style: TextStyle(fontSize: 24),))
                                ]
                              )
                            ]
                          )
                        ),
                      ),

                    )
                  ],


                ),
              )

                  ],
                ),
      ),



    );
  }

  void islemSec(Secenek secenek) async {
    int sonuc;
    switch (secenek) {
      case Secenek.sil:
        Navigator.pop(context, true);
        sonuc = await dbHelper.sil(urun.id);
        if (sonuc != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Silme İşlemi Başarılı"),
            content: Text("Silinen ürün : ${urun.ad}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
    }
  }
}
