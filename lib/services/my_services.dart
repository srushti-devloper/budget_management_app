import 'package:budget_tracker_app/modal/my_Expence.dart';
import 'package:budget_tracker_app/modal/my_budget.dart';
import 'package:budget_tracker_app/modal/my_sevings.dart';
import 'package:budget_tracker_app/repository.dart';

class MyServices {
  late Repository _repository;
  MyServices() {
    _repository = Repository();
  }

  insertBudgetService(MyBudget mybudget) async {
    return await _repository.insertBudget("mybudget", mybudget.MyBudgetMap());
  }

  historyGetAllBudget() async {
    return await _repository.selectMyBudget("mybudget");
  }

  deleteDataBudgetService(budgetId) async {
    return await _repository.deleteEntryFromBudget("mybudget", budgetId);
  }

  deleteDataSavingService(savingId) async {
    return await _repository.deleteEntryFromSaving("my_savings", savingId);
  }

  deleteDataExpanceService(expanceId) async {
    return await _repository.deleteEntryFromExpence("my_expance", expanceId);
  }

  fetchDataBudgetService(monthname) async {
    return await _repository.fetchEntryByMonthExpence("mybudget", monthname);
  }

  insertExpanceService(MyExpanse myexpence) async {
    return await _repository.insertExpence(
        "my_expance", myexpence.MyExpanseMap());
  }

  getExpanceHistory() async {
    return await _repository.selectMyExpence("my_expance");
  }

  insertSavingService(MySaving mySaving) async {
    return await _repository.insertSaving("my_savings", mySaving.mySavingMap());
  }

  getSavingHistory() async {
    return await _repository.fetchSavingsData("my_savings");
  }
}
