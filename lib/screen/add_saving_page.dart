import 'package:budget_tracker_app/modal/my_sevings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../services/my_services.dart';

class AddSavingPage extends StatefulWidget {
  const AddSavingPage({super.key});

  @override
  State<AddSavingPage> createState() => _AddSavingPageState();
}

class _AddSavingPageState extends State<AddSavingPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool titleValidator = false;
  bool amountValidator = false;

  var myservices = MyServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Add Saving",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          backgroundColor: Colors.green),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Budget Image Conatainer
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Image.asset(
                    'assets/images/budgeta.png',
                    fit: BoxFit.fill,
                  )),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 224, 247, 225),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 4,
                            color: Color.fromARGB(203, 24, 45, 14),
                            offset: Offset(0, 5))
                      ]),
                  child: Column(
                    children: [
                      // Add Expance TextForm Field
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.savings,
                            color: Colors.green,
                            size: 32,
                          ),
                          label: const Text(
                            "Add Saving Title",
                            style: TextStyle(color: Colors.green),
                          ),
                          hintText: "Enter Saving",
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.greenAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorText:
                              titleValidator ? "Field must reqired" : null,
                          errorStyle:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Enter Amount TextFormDield
                      TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                          label: const Text(
                            "Enter Amount",
                            style: TextStyle(color: Colors.green),
                          ),
                          errorText:
                              amountValidator ? "Field Must be Requird" : null,
                          errorStyle:
                              const TextStyle(color: Colors.red, fontSize: 16),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.greenAccent)),
                          icon: const Icon(
                            Icons.money,
                            color: Colors.green,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
// Button Add
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            titleController.text.isEmpty
                                ? titleValidator = true
                                : titleValidator = false;
                            amountController.text.isEmpty
                                ? amountValidator = true
                                : amountValidator = false;

                            if (titleValidator == false &&
                                amountValidator == false) {
                              var saving = MySaving();
                              saving.month = titleController.text.toString();

                              saving.amount = int.parse(amountController.text);
                              var now = DateTime.now();
                              var formmater = DateFormat('yyyy-MM-dd');
                              var fomattedDate = formmater.format(now);
                              saving.created_at = fomattedDate;
                              var result =
                                  myservices.insertSavingService(saving);

                              Fluttertoast.showToast(
                                  msg: "Submitted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  textColor: Colors.greenAccent,
                                  backgroundColor: Colors.green);

                              Navigator.pop(context, result);
                            } else {
                              if (kDebugMode) {
                                print("-----> something went wrong");
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green,
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 4,
                                    offset: Offset(0, 5),
                                    blurRadius: 6),
                              ]),
                          child: const Text(
                            "Add Expense",
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
