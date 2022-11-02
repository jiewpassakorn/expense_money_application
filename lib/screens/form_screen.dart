import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/main.dart';
import 'package:flutter_database/models/Transactions.dart';
import 'package:flutter_database/providers/transaction_provider.dart';
import 'package:flutter_database/screens/home_screen.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  //controller
  final titleController = TextEditingController(); //รับค่าชื่อรายการ
  final amountController = TextEditingController(); //รับค่าจำนวนเงิน
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ฟอร์ม"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                      autofocus: false,
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาระบุรายการ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                      controller: amountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาระบุจำนวนเงิน';
                        }
                        if (double.parse(value) <= 0) {
                          return "กรุณาระบุตัวเลขมากกว่า 0";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      child: Text("เพิ่มข้อมูล"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          var title = titleController.text;
                          var amount = amountController.text;

                          print(title);
                          print(amount);
                          // Prepare Data
                          Transactions statement = Transactions(
                              title: title,
                              amount: double.parse(amount),
                              date: DateTime.now());

                          // Call Provider
                          var provider = Provider.of<TransactionProvider>(
                              context,
                              listen: false);
                          provider.addTransaction(statement);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog:
                                      true, //Disable Backward button
                                  builder: ((context) => MyHomePage(
                                        title: '',
                                      ))));
                        }
                      },
                    )
                  ])),
        ));
  }
}
