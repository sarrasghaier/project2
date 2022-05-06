class Task {
  int? id;
  String? title;
  String? note;
  String? budget;
  int? isCompleted;
  String? date;
  String? startTime;
  String?  endTime;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.budget,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,



});
  Task.fromJson(Map<String, dynamic> json){
    id= json['id'];
    title=json['title'];
    note=json['note'];
    note=json['budget'];
    isCompleted=json['isCompleted'];
    date=json['date'];
    startTime=json['startTime'];
    endTime=json['endTime'];
    remind=json['remind'];
    repeat=json['repeat'];
  }
  Map<String, dynamic>toJson() {
    final Map<String, dynamic>data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['budget'] = this.budget;
    data['date'] = this.date;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    return data;
  }

}
