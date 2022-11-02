import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transaction_db.dart';
import 'package:flutter_database/models/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() => transactions;
  void initData() async {
    var db = TransactionDB(dbName: "transactions.db");
    // Select Data and Show
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    // var db = await TransactionDB(dbName: "transaction.db").openDatabase();
    // print(db);

    var db = TransactionDB(dbName: "transactions.db");
    //Save Data
    await db.InsertData(statement);

    // Select Data and Show
    transactions = await db.loadAllData();
    // แจ้งเตือน Consumer
    notifyListeners();
  }
}
