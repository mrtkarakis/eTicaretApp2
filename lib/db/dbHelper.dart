import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:e_ticaret_app2/models/Urun.dart';


class DbHelper{

  String tblUrun = "urunler";
  String colId = "id";
  String colAd = "ad";
  String colAciklama = "aciklama";
  String colFiyat = "fiyat";

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper(){
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async{
    if (_db==null){
      _db =await dbOlustur();
    }
    return _db;
  }

  Future<Database> dbOlustur()async{
    Directory directory  = await getApplicationDocumentsDirectory();
    String yol = directory.path + "eTicaret.db";
    var eTicaretDb = await openDatabase(yol,version: 1,onCreate: olustur);
    return eTicaretDb;
  }

  void olustur(Database db, int version) async {
    await db.execute("create table $tblUrun($colId integer primary key,$colAd text, $colAciklama text,$colFiyat int)");

  }

  Future<int> sil (int id ) async{
    Database db = await this.db;
    var sonuc = await db.rawDelete("Delete From $tblUrun where $colId = $id");
    return sonuc;
  }

  Future<int> ekle (Urun urun)async{
    Database db =await this.db;
    var sonuc = await db.insert(tblUrun,urun.MapYap());
    return sonuc;
  }

  Future<List> getUrunler() async{
    Database db = await this.db;
    var sonuc = await db.rawQuery("select * from $tblUrun");
    return sonuc;
  }

}