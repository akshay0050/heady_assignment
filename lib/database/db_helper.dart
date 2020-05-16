import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '_models/operation_result.dart';
import 'db_migration_helper.dart';

class DbHelper {
  static const int DB_VERSION = 1;
  static const String DB_NAME = "heady.db";

  Future<OperationResult> _migrationResult;

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    return await openDatabase(
      path,
      version: DB_VERSION,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    DbMigrationHelper migrationHelper = new DbMigrationHelper(db);
    Future<OperationResult> result = migrationHelper.migrateToDbVersion(1);
    _migrationResult = result;

    int currentRequiredVersion = DB_VERSION;

    if (currentRequiredVersion > 1) {
      result = migrationHelper.upgradeToVersion(1, currentRequiredVersion);
      _migrationResult = result;
    }

    _migrationResult.then((value) => _showResult(value, version)).catchError(
        (e) => print("Failed to create DB with starting version: " +
            version.toString()));
  }

  _showResult(OperationResult _migrationResult, int version) {
    if (_migrationResult.result == OperationResult.OPERATION_SUCCESSFUL) {
      print("Successfully created DB with starting version: " +
          version.toString());
    } else {
      print("Failed to create DB with starting version: " + version.toString());
    }
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    DbMigrationHelper migrationHelper = new DbMigrationHelper(db);
    Future<OperationResult> result =
        migrationHelper.upgradeToVersion(oldVersion, newVersion);
    _migrationResult = result;

    _migrationResult
        .then((value) => showUpgradeResult(value, oldVersion, newVersion))
        .catchError((e) => print("Failed to migrated DB with from version: " +
            oldVersion.toString() +
            " to " +
            newVersion.toString()));
  }

  showUpgradeResult(
      OperationResult _migrationResult, int oldVersion, int newVersion) {
    if (_migrationResult.result == OperationResult.OPERATION_SUCCESSFUL) {
      print("Successfully migrated DB with from version: " +
          oldVersion.toString() +
          " to " +
          newVersion.toString());
    } else {
      print("Failed to migrated DB with from version: " +
          oldVersion.toString() +
          " to " +
          newVersion.toString());
    }
  }
}
