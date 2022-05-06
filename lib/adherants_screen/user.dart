class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.telephone,
    required this.resetPasswordToken,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  String telephone;
  dynamic resetPasswordToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    telephone: json["telephone"],
    resetPasswordToken: json["resetPasswordToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "telephone": telephone,
    "resetPasswordToken": resetPasswordToken,
  };
}

