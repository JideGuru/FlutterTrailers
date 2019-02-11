import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:trailers/database/Download.dart';

class DBHelper{

  final String tableName = "userTable";
  final String columnId = "id";
  final String columnName = "name";
  final String columnPath = "path";


  static final DBHelper _instance = new DBHelper.internal();
  factory DBHelper() => _instance;

  static Database _db;
  Future<Database> get db async{
    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DBHelper.internal();

  initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate,);
    return ourDb;
  }




  void _onCreate(Database db, int newVersion) async{
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $tableName("
          "$columnId INTEGER PRIMARY KEY AUTO INCREAMENT, "
          "$columnName TEXT, "
          "$columnPath TEXT, "
          ")"
    );
  }



  //CRUD

  //Insertion
  Future<int> saveDownloads(Download download) async{

    var dbClient = await db;
    int res = await dbClient.insert("$tableName",  download.toMap());
    return res;
  }

  //Get Downloads
  Future<List> getDownloads() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName");
     return res.toList();

  }

  // Get Count
  Future<int> getCount() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName");
    return Sqflite.firstIntValue(res);

  }

  // A Download
  Future<Download> getDownload(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return Download.fromMap(res.first);
  }

//  //Delete a Download
//  Future<int> deleteDownload(int id) async{
//    var dbClient = await db;
//    return await dbClient.delete(
//        tableName,
//        where: "$columnId = ?",
//        whereArgs: [id]
//    );
//  }


//  //Update a Download
//  Future<int> updateDownload(Download download) async{
//    var dbClient = await db;
//    return await dbClient.update(
//      tableName,
//        download.toMap(),
//      where: "$columnId = ?",
//      whereArgs: [download.id]
//    );
//  }


  //Close the connection
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }


}