import 'package:budget_tracker_app/modal/my_sevings.dart';
import 'package:budget_tracker_app/screen/add_saving_page.dart';
import 'package:flutter/material.dart';

import '../services/my_services.dart';

class SavingHistoryPage extends StatefulWidget {
  const SavingHistoryPage({super.key});

  @override
  State<SavingHistoryPage> createState() => _SavingHistoryPageState();
}

class _SavingHistoryPageState extends State<SavingHistoryPage> {
  final List<MySaving> _savinghistorylist = <MySaving>[];
  final _myservices = MyServices();
  var totalsaving = 0;
  @override
  void initState() {
    getSavingHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saving History")),
      body: ListView.builder(
        shrinkWrap: true,
        key: Key(_savinghistorylist.length.toString()),
        itemCount: _savinghistorylist.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              onTap: (() {}),
              leading: const Icon(Icons.attach_money_outlined),
              title: Text(
                _savinghistorylist[index].amount.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              subtitle: Text(_savinghistorylist[index].month ?? ""),
              trailing: Text(_savinghistorylist[index].created_at.toString()),
              onLongPress: () {
                _deleteSavingEntery(context, _savinghistorylist[index], index);
              },
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddSavingPage(),
              )).then((value) {
            getSavingHistory();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getSavingHistory() async {
    var result = await _myservices.getSavingHistory();
    _savinghistorylist.clear();
    if (result != null) {
      result.forEach((entry) {
        setState(() {
          var mySaving = MySaving();
          mySaving.id = entry['id'];
          mySaving.month = entry['month'];
          mySaving.created_at = entry['created_at'];
          mySaving.amount = entry['amount'];

          _savinghistorylist.add(mySaving);
        });
      });
    }
  }

  _deleteSavingEntery(BuildContext context, MySaving mySaving, int index) {
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
                            .deleteDataSavingService(mySaving.id);

                        //if (result == 1) {
                        Navigator.pop(context, totalsaving);
                        _savinghistorylist.removeAt(index);
                        setState(() {});
                        //}
                      },
                      child: const Text("Yes")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, totalsaving);
                      },
                      child: const Text("No"))
                ],
              )
            ],
          );
        });
  }
}
