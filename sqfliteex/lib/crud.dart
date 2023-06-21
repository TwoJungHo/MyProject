import 'package:sqfliteex/sample.dart';
import 'package:sqfliteex/sqldatabase.dart';

class SqlSampleCrudRepository{
  static Future<Sample> create(Sample sample) async{
    var db = await SqlDataBase.instance.database;
    var id = await db.insert(Sample.tableName, sample.toJson());

    return sample.updateSample(id : id);
  }

  static Future<List<Sample>> getList() async{
    var db = await SqlDataBase.instance.database;
    var result = await db.query(
        Sample.tableName,
        columns: ["id", "name", "yn", "createAt"],
        orderBy: "createAt DESC");

    return result.map((e) => Sample.fromJson(e)).toList();
  }

  static Future<Sample?> getSampleId(int id) async{
    var db = await SqlDataBase.instance.database;
    var result = await db.query(
        Sample.tableName,
        columns: ["id", "name", "yn", "value", "createAt"],
        where: "id=?",
        whereArgs: [id]);

    var list = result.map((e) => Sample.fromJson(e)).toList();
    if(list.isNotEmpty){
      return list.first;
    }else{
      return null;
    }
  }

  static Future<int> updateById(Sample sample) async{
    var db = await SqlDataBase.instance.database;
    return await db.update(Sample.tableName, sample.toJson(), where: "id=?", whereArgs: [sample.id]);
  }

  static Future<int> DeleteById(int id) async{
    var db = await SqlDataBase.instance.database;
    return await db.delete(Sample.tableName, where: "id=?", whereArgs: [id]);
  }
}


























