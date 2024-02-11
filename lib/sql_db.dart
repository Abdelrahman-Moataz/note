import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;


  // if the database is not init it will init it
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    // to make the default pah of the db
    String databasePath = await getDatabasesPath();
    // to add the name of the file to the path
    String path = join(databasePath, "data.db");
    // to create the file
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1 , onUpgrade: _onUpgrade);
    return myDb;
  }


  _onUpgrade(Database db, int oldVersion, int newVersion){

  }


  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "notes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
    "note" TEXT NOT NULL
    ''');
  }

  // select

readData(String sql)async{
    Database? myDB = await db;
    List<Map> response = await myDB!.rawQuery(sql);
    return response ;
}
   //insert
  insertData(String sql)async{
    Database? myDB = await db;
    int response = await myDB!.rawInsert(sql);
    return response ;
  }

  //update
  updateData(String sql)async{
    Database? myDB = await db;
    int response = await myDB!.rawUpdate(sql);
    return response ;
  }

  //delete
  deleteData(String sql)async{
    Database? myDB = await db;
    int response = await myDB!.rawDelete(sql);
    return response ;
  }



}
