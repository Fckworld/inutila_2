import 'dart:async';
import 'dart:io' as io;
import 'package:flutter_entrega_2/models/car.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String PATENTE = 'patente';
  static const String MARCA = 'marca';
  static const String PRECIO = 'precio';
  static const String TABLE = 'Car';
  static const String DB_NAME = 'car1.db';

  Future<Database> get db async { //Comprueba existencia de db
    if (_db != null) {
      return _db;
    }
    _db = await initDb(); //No existe, entonces la inicializo.
    return _db;
  }

  initDb() async {//CREACION DATABASE
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async { //CREACION TABLA
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $PATENTE TEXT, $MARCA TEXT, $PRECIO TEXT)");
  }

  Future<Car> save(Car car) async { //AGREGAR A LA TABLA
    var dbClient = await db;
    car.id = await dbClient.insert(TABLE, car.toMap());
    return car;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Car>> getCars() async { //LISTAR TABLA
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID,PATENTE,MARCA, PRECIO]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Car> cars = [];
    if (maps.length > 0) {          //SI HAY ALGO EN LA LISTA  DE MAPAS, LO RECORRO PARA AGREGARLOS
      for (int i = 0; i < maps.length; i++) {
        cars.add(Car.fromMap(maps[i]));
      }
    }
    return cars; //RETORNO LA LISTA ENTERA CON LOS MAPS (LA INFO.)
  }

  Future<int> delete(int id) async { //ELIMINAR
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Car car) async { //ACTUALIZAR
    var dbClient = await db;
    return await dbClient.update(TABLE, car.toMap(),
        where: '$ID = ?', whereArgs: [car.patente]);
  }

  Future close() async { //CERRAR DATABASE
    var dbClient = await db;
    dbClient.close();
  }
}
