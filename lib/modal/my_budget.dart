class MyBudget {
  int? id;
  String? month;
  String? title;
  int? amount;
  String? created_at;

  MyBudgetMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['month'] = month!;
    mapping['title'] = title;
    mapping['amount'] = amount;
    mapping['created_at'] = created_at;

    return mapping;
  }
}
