import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Expense Tracker by jiewpassakorn"),
          actions: [
            IconButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: TextStyle(fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      elevation: 8,
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(
                              child: Text(data.amount.toString()),
                            )),
                        title: Text(data.title),
                        subtitle:
                            Text(DateFormat("dd/MM/yyyy").format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
