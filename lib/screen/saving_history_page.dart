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
  List<MySaving> mySavingList = [];
  final _myservices = MyServices();
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
        key: Key(mySavingList.length.toString()),
        itemCount: mySavingList.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              onTap: (() {}),
              leading: const Icon(Icons.attach_money_outlined),
              title: Text(
                mySavingList[index].amount.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              subtitle: Text(mySavingList[index].month ?? ""),
              trailing: Text(mySavingList[index].created_at.toString()),
              onLongPress: () {},
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
    mySavingList.clear();
    if (result != null) {
      result.forEach((entry) {
        setState(() {
          var mySaving = MySaving();
          mySaving.id = entry['id'];
          mySaving.month = entry['month'];
          mySaving.created_at = entry['created_at'];
          mySaving.amount = entry['amount'];

          mySavingList.add(mySaving);
        });
      });
    }
  }
}
