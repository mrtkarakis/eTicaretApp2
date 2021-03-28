import 'package:e_ticaret_app2/db/dbHelper.dart';
import 'package:e_ticaret_app2/models/Urun.dart';
import 'package:flutter/material.dart';
import 'UrunDetay.dart';
import 'UrunEkle.dart';

class UrunListesi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UrunListesiState();
  }
}

class UrunListesiState extends State {
  DbHelper dbHelper = new DbHelper();
  List<Urun> urunler;
  int urunSayisi = 0;
  @override
  Widget build(BuildContext context) {
    if (urunler == null) {
      urunler = new List<Urun>();
      getUrunler();
    }
    return Scaffold(
      body: urunListesi(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
        onPressed: () {
          urunEkleyeGit();
        },
      ),
    );
  }

  ListView urunListesi() {
    return ListView.builder(
        itemCount: urunSayisi,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            elevation: 3,
            color: Colors.white24,
            child: ListTile(
              leading: Icon(
                Icons.style,
                size: 32,
                color: Colors.blueGrey,
              ),
              title: Text(this.urunler[position].ad),
              subtitle: Text(this.urunler[position].aciklama),
              trailing: Icon(
                Icons.shop_outlined,
                color: Colors.blueGrey,
                size: 28,
              ),
              onTap: () {
                detayaGit(this.urunler[position]);
              },
            ),
          );
        });
  }

  void getUrunler() {
    var dbFuture = dbHelper.dbOlustur();
    dbFuture.then((sonuc) {
      var urunlerFuture = dbHelper.getUrunler();
      urunlerFuture.then((data) {
        List<Urun> urunlerData = new List<Urun>();
        var gelenUrunSayisi = data.length;
        for (int i = 0; i < gelenUrunSayisi; i++) {
          urunlerData.add(Urun.formObject(data[i]));
        }
        setState(() {
          urunler = urunlerData;
          urunSayisi = gelenUrunSayisi;
        });
      });
    });
  }

  void detayaGit(Urun urun) async {
    bool sonuc = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UrunDetay(urun)));
    if (sonuc != null) {
      if (sonuc) {
        getUrunler();
      }
    }
  }

  void urunEkleyeGit() async {
    bool sonuc = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UrunEkle()));
    if (sonuc != null) {
      if (sonuc) {
        getUrunler();
      }
    }
  }
}


// class UrunListesi extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return UrunListesiState();
//   }
// }
//
// class UrunListesiState extends State {
//   DbHelper dbHelper = new DbHelper();
//   List<Urun> urunler;
//   int urunSayisi = 0;
//   @override
//   Widget build(BuildContext context) {
//     if (urunler == null) {
//       urunler = new List<Urun>();
//       getUrunler();
//     }
//     return Scaffold(
//       body: urunListesi(),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         tooltip: "yeni ürün ekle",
//         onPressed: () {
//           urunEkleyeGit();
//         },
//       ),
//     );
//   }
//
//   ListView urunListesi() {
//     return ListView.builder(
//         itemCount: urunSayisi,
//         itemBuilder: (BuildContext context, int position) {
//           return Card(
//             elevation: 1,
//             color: Colors.green[200],
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.blueAccent,
//               ),
//               title: Text(this.urunler[position].ad),
//               subtitle: Text(this.urunler[position].aciklama),
//               onTap: () {
//                 detayaGit(this.urunler[position]);
//               },
//             ),
//           );
//         });
//   }
//
//   void getUrunler() {
//     var dbFuture = dbHelper.dbOlustur();
//     dbFuture.then((sonuc) {
//       var urunlerFuture = dbHelper.getUrunler();
//       urunlerFuture.then((data) {
//         List<Urun> urunlerData = new List<Urun>();
//         var gelenUrunSayisi = data.length;
//         for (int i = 0; i < gelenUrunSayisi; i++) {
//           urunlerData.add(Urun.formObject(data[i]));
//         }
//         setState(() {
//           urunler = urunlerData;
//           urunSayisi = gelenUrunSayisi;
//         });
//       });
//     });
//   }
//
//   void detayaGit(Urun urun) async {
//     bool sonuc = await Navigator.push(
//         context, MaterialPageRoute(builder: (context) => UrunDetay(urun)));
//     if (sonuc != null) {
//       if (sonuc) {
//         getUrunler();
//       }
//     }
//   }
//
//   void urunEkleyeGit() async {
//     bool sonuc = await Navigator.push(
//         context, MaterialPageRoute(builder: (context) => UrunEkle()));
//     if (sonuc != null) {
//       if (sonuc) {
//         getUrunler();
//       }
//     }
//   }
// }
