import 'dart:ffi';
import 'dart:io';

import 'package:flutter_database/models/Transactions.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String dbName;

  TransactionDB({required this.dbName});
  // dbLocation = users/kongruksiam/trasaction.db
  // dbName = transaction.db
  Future<Database> openDatabase() async {
    // Find Directory of Database
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    // Create Database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // Save Data to Store
  Future<int> InsertData(Transactions statement) async {
    // Database => Store
    // transaction.db =>  expense
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  // Select Data
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transectionList =
        List<Transactions>.from(<List<Transactions>>[]);
    for (dynamic record in snapshot) {
      transectionList.add(Transactions(
          title: record["title"],
          amount: record["amount"],
          date: DateTime.parse(record["date"])));
    }
    return transectionList;
  }
}
