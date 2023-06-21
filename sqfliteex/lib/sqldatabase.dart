import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqfliteex/sample.dart';

class SqlDataBase{
  Database? _database;

  static final SqlDataBase instance = SqlDataBase._instance();

  SqlDataBase._instance(){
    _initDataBase();
  }

  factory SqlDataBase(){
    return instance;
  }

  Future<Database> get database async{
    if(_database != null) _database;
    await _initDataBase();
    return _database!;
  }

  Future<void> _initDataBase() async{
    var databasePath =  await getDatabasesPath();
    String path = join(databasePath, "sample.db");
    _database = await openDatabase(path, version: 1, onCreate:  _dataBaseCreate);
  }
  
  void _dataBaseCreate(Database db, int version) async{
    await db.execute("""
    create table ${Sample.tableName} (
      id integer primary key autoincrement,
      name text not null,
      yn integer not null,
      value integer not null,
      createAt text not null
    )
    """);
  }
}