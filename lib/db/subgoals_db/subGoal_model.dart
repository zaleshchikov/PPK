class SubGoalModel{
  String name;
  String mainGoal;
  int id;
  SubGoalModel({required this.name, required this.isCompleted, required this.mainGoal, this.id = 0});
  bool isCompleted;

  Map<String, dynamic> toMap() => {
    "name": name,
    "isCompleted": isCompleted.toString(),
    "mainGoal": mainGoal
  };

  static SubGoalModel fromMap(Map<String, dynamic> map) => SubGoalModel(
      id: map['_id'],
      name: map["name"]!,
      isCompleted: map["isCompleted"]! == 'true',
      mainGoal: map["mainGoal"]!);

  static SubGoalModel fromServerMap(Map<String, dynamic> map) => SubGoalModel(
      id: map['id'],
      name: map["text"]!,
      isCompleted: map["is_completed"] ?? false,
      mainGoal: ''
  );
}