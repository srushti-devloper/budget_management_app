// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:budget_tracker_app/modal/my_Expence.dart';
import 'package:budget_tracker_app/screen/add_expenses_page.dart';
import 'package:budget_tracker_app/services/my_services.dart';
import 'package:flutter/material.dart';

class MySavingsPage extends StatefulWidget {
  const MySavingsPage({super.key});

  @override
  State<MySavingsPage> createState() => _MySavingsPageState();
}

class _MySavingsPageState extends State<MySavingsPage> {
  final List<MyExpanse> _expansehistorylist = <MyExpanse>[];
  var _myservices = MyServices();

  var totalBudget = 0;

  @override
  void initState() {
    getExpanceHistory();
    super.initState();
  }

  void getExpanceHistory() async {
    var expanseresult = await _myservices.getExpanceHistory();
    _expansehistorylist.clear();
    if (expanseresult != null) {
      expanseresult.forEach((Entry) {
        setState(() {
          var myExpanse = MyExpanse();
          myExpanse.id = Entry['id'];
          myExpanse.title = Entry['title'];
          myExpanse.amount = Entry['amount'];
          myExpanse.created_at = Entry['created_at'];
          totalBudget += myExpanse.amount!;
          _expansehistorylist.add(myExpanse);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "My Expencess",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          backgroundColor: Colors.green),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AddExpencesPgae())))
                .then((value) {
              getExpanceHistory();
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _expansehistorylist.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              onTap: (() {}),
              leading: const Icon(Icons.money_off),
              title: Text(
                _expansehistorylist[index].amount.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              subtitle: Text(_expansehistorylist[index].title.toString()),
              trailing: Text(_expansehistorylist[index].created_at.toString()),
              onLongPress: () {
                _deleteExpanceEntery(
                    context, _expansehistorylist[index], index);
              },
            ),
          );
        }),
      ),
    );
  }

  _deleteExpanceEntery(BuildContext context, MyExpanse myExpanse, int index) {
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
                            .deleteDataExpanceService(myExpanse.id);

                        //if (result == 1) {
                        Navigator.pop(context, totalBudget);
                        _expansehistorylist.removeAt(index);
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
