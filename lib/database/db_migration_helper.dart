import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '_models/operation_result.dart';


class DbMigrationHelper {
  static const DB_MIGRATION_FILE_PREFIX = "db_version_";
  static const DB_MIGRATION_FILE_SUFFIX = ".sql";

  String fileNameForVersion(var version) {
    return "/" + DB_MIGRATION_FILE_PREFIX + version + DB_MIGRATION_FILE_SUFFIX;
  }

  Database db;

  DbMigrationHelper(Database db) {
    this.db = db;
  }

  Future<OperationResult> migrateToDbVersion(int version) async {
    try {
      String filePath =
          './assets/sql/db_version_' + version.toString() + '.sql';
      String fileStr = await loadAsset(filePath);

      LineSplitter ls = new LineSplitter();
      List<String> lines = ls.convert(fileStr);
      for (var i = 0; i < lines.length; i++) {
        db.execute(lines[i]);
      }
      OperationResult result =
          OperationResult(OperationResult.OPERATION_SUCCESSFUL);
      return _createCompleter(result).future;
    } catch (e) {
      OperationResult result =
          OperationResult(OperationResult.OPERATION_FAILED);
      return _createCompleter(result).future;
    }
  }

  Completer<OperationResult> _createCompleter(OperationResult result) {
    var completer = new Completer<OperationResult>();
    completer.complete(result);
    return completer;
  }

  Future<OperationResult> upgradeToVersion(
      int oldVersion, int newVersion) async {
    Future<OperationResult> operationResult;
    for (int i = oldVersion + 1; i <= newVersion; i++) {
      operationResult = migrateToDbVersion(i);
    }
    return operationResult;
  }

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}
