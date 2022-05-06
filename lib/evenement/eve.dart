class eve {
  eve({
    required this.id,
    required this.name,
    required this.budget,
    required this.date,
    required this.note,
    required this.image,
    required this.statut,
  });

  int id;
  String name;
  String budget;
  DateTime date;
  String note;
  String image;
  String statut;

  factory eve.fromJson(Map<String, dynamic> json) => eve(
    id: json["id"],
    name: json["name"],
    budget: json["budget"],
    date: json["date"],
    note: json["note"],
    image: json["image"], statut: '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "budget": budget,
    "date": date,
    "note": note,
    "image": image,
  };
}