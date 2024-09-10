import 'package:diabetes_diary_app/model/bean.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class IdentifiableEntityRepository <T> {

  Future<Database>? database;

  IdentifiableEntityRepository() {
    init();
  }

  /// Initialize database connection
  /// When creating the database we voluntarily omit the uniqueness constraints for the foreign keys.
  void init () async {
    database = openOurDatabase();
  }

  Future<Database> openOurDatabase () async {
    return await openDatabase(
        join(await getDatabasesPath(), "diabetes_diary_app.db"),
        onCreate: (db, version) {
          db.execute("CREATE TABLE insulin_type(id INTEGER, name TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))");
          db.execute("CREATE TABLE bread_config(id INTEGER, name TEXT NOT NULL, carbohydrate_per_serving REAL NOT NULL, PRIMARY KEY(id AUTOINCREMENT))");
          db.execute("CREATE TABLE insulin(id INTEGER, injected_quantity REAL NOT NULL, type_id INTEGER NOT NULL, day_date TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))");
          db.execute("CREATE TABLE glucose(id INTEGER, taken_value REAL NOT NULL, day_date TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))");
          db.execute("CREATE TABLE bread_unit(id INTEGER, serving REAL NOT NULL, bread_id INTEGER NOT NULL, day_date TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))");


          //insert data to initialize database
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane 30 InnoLet 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane 30 NovoLet 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane 30 Penfill 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane 50 NovoLet 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane 50 Penfill 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane InnoLet 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane NovoLet 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Actraphane Penfill 3ml 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Apidra 100 I.E/ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Apidra 100 E/ml 3ml')");
          db.execute("INSERT INTO insulin_type (name) VALUES('Apidra OpitiSet 100 E/ml 3ml')");

          db.execute("INSERT INTO bread_config(name, carbohydrate_per_serving) VALUES('Ripe banana', 5)");
          db.execute("INSERT INTO bread_config(name, carbohydrate_per_serving) VALUES('Salad', 2)");
          db.execute("INSERT INTO bread_config(name, carbohydrate_per_serving) VALUES('Bread', 2)");
          db.execute("INSERT INTO bread_config(name, carbohydrate_per_serving) VALUES('Milk', 10)");
        },
        version: 1
    );
  }

  Future<Database> getDatabase () async {
    Database? db = await database;

    if (db == null) {
      database = openOurDatabase();

      db = await database;
      if (db == null) {
        throw Exception("Database are not initialized");
      }
    }

    return db;
  }

  /// Find occurrence by ID in table in database
  Future<T?> find (int id) async {
    final db = await getDatabase();

    final List<Map<String, Object?>> maps = await db.query(
      getTableName(),
      where: "id = ?",
      whereArgs: [id]
    );

    List<T> items  = <T> [
      for (final item in maps)
        await mapping(item)
    ];

    return items.isEmpty ? null : items[0];
  }

  /// find all data in table in our database
  Future<List<T>> findAll ({int limit = 0, int offset = 0}) async {
    final db = await getDatabase();

    final List<Map<String, Object?>> maps = await db.query(
        getTableName(),
        orderBy: "id DESC",
        limit: limit != 0 ? limit : 20,
        offset: offset
    );

    return <T> [
      for (final item in maps)
        await mapping(item)
    ];
  }

  ///Remove occurrence by ID
  Future<void> remove (int id) async {
    final db = await getDatabase();

    await db.delete(
      getTableName(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<T> create (T data) {
    throw Exception("you need to define the create() method");
  }

  Future<T> update (T data) {
    throw Exception("you need to define the update() method");
  }

  String getTableName () {
    throw Exception("you need to define the getTableName() method");
  }

  Future<T> mapping (Map<String, Object?> data) async {
    throw Exception("you need to define the mapping() method");
  }
}

class InsulinTypeRepository extends IdentifiableEntityRepository<InsulinType> {

  static InsulinTypeRepository? instance;

  InsulinTypeRepository() {
    init();
  }

  static InsulinTypeRepository getInstance () {
    InsulinTypeRepository.instance ??= InsulinTypeRepository();
    InsulinTypeRepository? check = InsulinTypeRepository.instance;
    if (check == null) {
      throw Exception("never");
    }

    return check;
  }

  @override
  String getTableName () {
    return "insulin_type";
  }

  @override
  Future<InsulinType> mapping (Map<String, Object?> data) async {
    return InsulinType(id: data["id"] as int, name: data["name"] as String);
  }
}

class InsulinRepository extends ManagedParametersRepository<Insulin> {

  static InsulinRepository? instance;
  late final InsulinTypeRepository typeRepository;

  InsulinRepository() {
    init();
    typeRepository = InsulinTypeRepository.getInstance();
  }

  static InsulinRepository getInstance () {
    InsulinRepository.instance ??= InsulinRepository();
    InsulinRepository? check = InsulinRepository.instance;

    if (check == null) {
      throw Exception("Never");
    }

    return check;
  }

  @override
  Future<Insulin> create (Insulin data) async {
    final db = await getDatabase();

    await db.insert(
      getTableName(),
      {
        "injected_quantity": data.injectedQuantity,
        "day_date": data.dayDate,
        "type_id": data.type?.id
      }
    );

    return data;
  }

  @override
  String getTableName () {
    return "insulin";
  }

  @override
  Future<Insulin> mapping (Map<String, Object?> data) async {
    return Insulin(
      id: data["id"] as int,
      injectedQuantity: data["injected_quantity"] as double,
      dayDate: data["day_date"] as String,
      type: await typeRepository.find(data["type_id"] as int)
    );
  }
}

class BreadConfigRepository extends IdentifiableEntityRepository<BreadConfig> {

  @override
  String getTableName () {
    return "bread_config";
  }

  @override
  Future<BreadConfig> mapping (Map<String, Object?> data) async {
    return BreadConfig(
      id: data["id"] as int,
      name: data["name"] as String,
      carbohydratePerServing: data["carbohydrate_per_serving"] as double
    );
  }
}

class ManagedParametersRepository<T>  extends IdentifiableEntityRepository<T> {

  Future<List<T>> findAllAt(String dayDate) async {
    final db = await getDatabase();

    final List<Map<String, Object?>> maps = await db.query(
      getTableName(),
      where: "day_date = ?",
      whereArgs: [dayDate]
    );

    return <T> [
      for (final item in maps)
        await mapping(item)
    ];
  }
}

class GlucoseRepository extends ManagedParametersRepository<Glucose>{

  static GlucoseRepository? instance;

  GlucoseRepository() {
    init();
  }

  static GlucoseRepository getInstance () {
    GlucoseRepository.instance ??= GlucoseRepository();
    GlucoseRepository? check = instance;
    if (check == null) {
      throw Exception("Never");
    }
    return check;
  }

  @override
  String getTableName () {
    return "glucose";
  }

  @override
  Future<Glucose> mapping (Map<String, Object?> data) async {
    Glucose item = Glucose();
    item.id = data["id"] as int;
    item.dayDate = data["day_date"] as String;
    item.takenValue = data["taken_value"] as double;
    return item;
  }

  @override
  Future<Glucose> create (Glucose data) async {
    final db = await getDatabase();

    await db.insert(
      getTableName(), {
        "taken_value": data.takenValue,
        "day_date": data.dayDate
      }
    );

    return data;
  }

  @override
  Future<Glucose> update (Glucose data) async {
    final db = await getDatabase();

    await db.update(
      getTableName(),
      {
        "taken_value": data.takenValue,
        "day_date": data.dayDate
      },
      where: "id = ?",
      whereArgs: [data.id]
    );

    return data;
  }
}