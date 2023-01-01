import 'package:budget_tracker_app/modal/my_budget.dart';
import 'package:budget_tracker_app/services/my_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  TextEditingController mountController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool mountValidtor = false;
  bool amountValidtor = false;

  var myservices = MyServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: const Color.fromARGB(255, 52, 156, 208),
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Add Budget",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 36,
            ),
            TextFormField(
              controller: mountController,
              decoration: InputDecoration(
                label: const Text(
                  "Enter Month",
                  style: TextStyle(color: Colors.green),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                errorText: mountValidtor ? "Field must reqired" : null,
                errorStyle: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              onSaved: ((newValue) {}),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                label: const Text(
                  "Enter Amount",
                  style: TextStyle(color: Colors.green),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                errorText: amountValidtor ? "Field must reqired" : null,
                errorStyle: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              onSaved: ((newValue) {}),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 0);
                      setState(() {
                        amountController.text = "";
                        mountController.text = "";
                      });
                    },
                    child: const Text("Cancel")),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      mountController.text.isEmpty
                          ? mountValidtor = true
                          : mountValidtor = false;

                      amountController.text.isEmpty
                          ? amountValidtor = true
                          : amountValidtor = false;
                    });

                    if (mountValidtor == false && amountValidtor == false) {
                      var budget = MyBudget();

                      budget.amount =
                          int.parse(amountController.text.toString());
                      budget.month = mountController.text;
                      print(
                          "month---------------------------->${budget.amount}");
                      var now = DateTime.now();
                      var formmater = DateFormat('yyyy-MM-dd');
                      var fomattedDate = formmater.format(now);
                      budget.created_at = fomattedDate;
                      budget.title = "AAA";
                      var result = await myservices.insertBudgetService(budget);

                      Fluttertoast.showToast(
                          msg: "Submitted",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          textColor: Colors.blue,
                          backgroundColor: Colors.grey);

                      Navigator.pop(context, budget.amount);
                    } else {
                      print("-----> something went wrong");
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
