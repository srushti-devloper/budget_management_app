class MySaving {
  int? id;
  String? month;
  String? title;

  int? amount;
  String? created_at;

  mySavingMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['month'] = month!;
    //mapping['title'] = title!;
    mapping['amount'] = amount;
    mapping['created_at'] = created_at;

    return mapping;
  }
}
