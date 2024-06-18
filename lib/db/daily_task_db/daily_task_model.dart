class DailyTask {
  String name;
  bool done;
  DateTime date;
  int id;
  int vladId;

  DailyTask(
      {required this.name,
      required this.done,
      required this.date,
      this.id = 0,
      this.vladId = 0});

  Map<String, dynamic> toMap() => {
        "name": name,
        "done": done.toString(),
        "date": "${date.day}-${date.month}-${date.year}",
        'vladId': vladId.toString()
      };

  static DailyTask fromMap(Map<String, dynamic> map) => DailyTask(
      id: map['_id'],
      name: map["name"]!,
      done: map["done"]! == 'true',
      date: DateTime.utc(
          int.parse(map["date"]!.split('-')[2]),
          int.parse(map["date"]!.split('-')[1]),
          int.parse(map["date"]!.split('-')[0])),
      vladId: int.parse(map['vladId']));
}
