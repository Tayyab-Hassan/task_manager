class Task {
  int? id, isCompleted, color, remind;
  String? title, discreption, date, startTime, endTime, repeat;
  Task({
    this.id,
    this.title,
    this.discreption,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    discreption = json['discreption'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["discreption"] = discreption;
    data["isCompleted"] = isCompleted;
    data["date"] = date;
    data["startTime"] = startTime;
    data["endTime"] = endTime;
    data["color"] = color;
    data["remind"] = remind;
    data["repeat"] = repeat;
    return data;
  }
}
