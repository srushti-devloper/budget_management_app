// ignore_for_file: unused_import

import 'package:budget_tracker_app/screen/add_budgetscren.dart';
import 'package:budget_tracker_app/screen/budget_history_screen.dart';
import 'package:budget_tracker_app/screen/expences_page.dart';
import 'package:budget_tracker_app/screen/saving_history_page.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../modal/my_Expence.dart';
import '../modal/my_budget.dart';
import '../modal/my_sevings.dart';
import '../services/my_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var R = 0;
  var totalBudget = 0;
  var totalExpense = 0;
  var totalSaving = 0;
  var dataMap = <String, double>{
    "Expense": 0,
    "Savings": 0,
  };

  final colorList = <Color>[Colors.greenAccent, Colors.lightGreen];

  final _myservices = MyServices();
  @override
  void initState() {
    getTotalBudget();
    getTotalExpense();
    getTotalSavings();

    setState(() {
      dataMap = <String, double>{
        "Expense": totalExpense.toDouble(),
        "Savings": totalSaving.toDouble(),
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: const Color.fromARGB(255, 224, 247, 225),
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 139, 250, 143),
                                Color.fromARGB(255, 28, 109, 30)
                              ]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "RS. $totalBudget",
                            style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height / 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color.fromARGB(255, 139, 250, 143),
                                    Color.fromARGB(255, 45, 148, 46)
                                  ]),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const AddBudgetScreen())));
                              },
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  const Text("Add Budget")
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height / 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color.fromARGB(255, 139, 250, 143),
                                    Color.fromARGB(255, 45, 148, 46)
                                  ]),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const MyBudgetHistory())));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.history_toggle_off_outlined,
                                    color: Colors.white,
                                  ),
                                  const Text("View History")
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: PieChart(
                              dataMap: {
                                "Expense": totalExpense.toDouble(),
                                "Savings": totalSaving.toDouble(),
                              },
                              chartType: ChartType.ring,
                              baseChartColor:
                                  Colors.grey[50]!.withOpacity(0.15),
                              colorList: colorList,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              totalValue:
                                  double.tryParse(totalBudget.toString()),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const MySavingsPage())));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 139, 250, 143),
                              Color.fromARGB(255, 45, 148, 46)
                            ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Image.asset('assets/images/Expences.png'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "My Expense",
                            style:
                                TextStyle(fontSize: 36, color: Colors.white70),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SavingHistoryPage(),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 139, 250, 143),
                              Color.fromARGB(255, 45, 148, 46)
                            ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Image.asset(
                              'assets/images/seaving.png',
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "My Savings",
                            style:
                                TextStyle(fontSize: 36, color: Colors.white70),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> getTotalBudget() async {
    var result = await _myservices.historyGetAllBudget();

    final List<MyBudget> list = <MyBudget>[];
    list.clear();
    if (result != null) {
      result.forEach((entry) {
        setState(() {
          var myBudget = MyBudget();
          myBudget.amount = entry['amount'];
          totalBudget += myBudget.amount!;
          list.add(myBudget);
        });
      });
    }
  }

  void getTotalExpense() async {
    var expanseresult = await _myservices.getExpanceHistory();
    if (expanseresult != null) {
      expanseresult.forEach((Entry) {
        setState(() {
          var myExpanse = MyExpanse();
          myExpanse.amount = Entry['amount'];
          totalExpense += myExpanse.amount!;
        });
      });
    }
  }

  Future<void> getTotalSavings() async {
    var result = await _myservices.getSavingHistory();

    if (result != null) {
      result.forEach((entry) {
        setState(() {
          var mySaving = MySaving();
          mySaving.id = entry['id'];
          mySaving.month = entry['month'];
          mySaving.created_at = entry['created_at'];
          mySaving.amount = entry['amount'];

          totalSaving += mySaving.amount!;
        });
      });
    }

    setState(() {
      dataMap = <String, double>{
        "Expense": totalExpense.toDouble(),
        "Savings": totalSaving.toDouble(),
      };
    });
  }
}
