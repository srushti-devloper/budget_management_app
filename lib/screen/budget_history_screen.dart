// ignore_for_file: use_build_context_synchronously

import 'package:budget_tracker_app/modal/my_budget.dart';
import 'package:budget_tracker_app/services/my_services.dart';
import 'package:flutter/material.dart';

class MyBudgetHistory extends StatefulWidget {
  const MyBudgetHistory({super.key});

  @override
  State<MyBudgetHistory> createState() => _MyBudgetHistoryState();
}

class _MyBudgetHistoryState extends State<MyBudgetHistory> {
  final List<MyBudget> _budgethistorylist = <MyBudget>[];
  final _myservices = MyServices();

  var totalBudget = 0;
  @override
  void initState() {
    super.initState();
    historyGetAllBudget();
  }

  void historyGetAllBudget() async {
    var result = await _myservices.historyGetAllBudget();
    _budgethistorylist.clear();
    if (result != null) {
      result.forEach((entry) {
        setState(() {
          var myBudget = MyBudget();
          myBudget.id = entry['id'];
          myBudget.month = entry['month'];
          myBudget.title = entry['title'];
          myBudget.created_at = entry['created_at'];
          myBudget.amount = entry['amount'];
          totalBudget += myBudget.amount!;
          _budgethistorylist.add(myBudget);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          key: Key(_budgethistorylist.length.toString()),
          itemCount: _budgethistorylist.length,
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                onTap: (() {}),
                leading: const Icon(Icons.attach_money_outlined),
                title: Text(
                  _budgethistorylist[index].amount.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                subtitle: Text(_budgethistorylist[index].month ?? ""),
                trailing: Text(_budgethistorylist[index].created_at.toString()),
                onLongPress: () {
                  _deleteBudgetEntery(
                      context, _budgethistorylist[index], index);
                },
              ),
            );
          }),
        ));
  }

  _deleteBudgetEntery(BuildContext context, MyBudget myBudget, int index) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text("Are you sure you wany to delete?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var result = await _myservices
                            .deleteDataBudgetService(myBudget.id);

                        //if (result == 1) {
                        Navigator.pop(context, totalBudget);
                        _budgethistorylist.removeAt(index);
                        setState(() {});
                        //}
                      },
                      child: const Text("Yes")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, totalBudget);
                      },
                      child: const Text("No"))
                ],
              )
            ],
          );
        });
  }
}
