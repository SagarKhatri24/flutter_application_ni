import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper{

  static final databseName = "student.db";

  static final databaseVersion = 1;

  static final tableName = "users";

  static final userId = "userId";
  static final name = "name";
  static final email = "email";
  static final contact = "contact";
  static final password = "password";

  static final SqliteHelper instance = SqliteHelper();

  Database? mainDatabase = null;

  Future<Database?> get database async{
    if(mainDatabase!=null) return mainDatabase;
    mainDatabase = await initDatabase();
    return mainDatabase;
  }

  initDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path,databseName);
    return await openDatabase(path,version: databaseVersion,onCreate: onCreateMethod);
  }

  Future onCreateMethod(Database db,int version) async {
    await db.execute(''' 
      CREATE TABLE $tableName(
        $userId INTEGER PRIMARY KEY,
        $name VARCHAR(50),
        $email VARCHAR(50),
        $contact VARCHAR(50),
        $password VARCHAR(50)
      )
     ''');
  }  

  Future<int> insertFun(Map<String,dynamic> map) async{
    Database? db = await instance.database;
    return db!.insert(tableName, map);
  } 

  Future<List<Map<String,dynamic>>> checkUserData(String sEmail,String sContact) async{
    Database? db = await instance.database;
    return await db!.query(tableName,where: '$email = ? OR $contact = ?',whereArgs: [sEmail,sContact]);
  } 

  Future<List<Map<String,dynamic>>> loginData(String sEmail,String sPassword) async{
    Database? db = await instance.database;
    return await db!.query(tableName,where: '($email = ? OR $contact = ?) AND $password = ?',whereArgs: [sEmail,sEmail,sPassword]);
  } 

}