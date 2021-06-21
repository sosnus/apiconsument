class User {
  final String firstName;
  final String middleName;
  final String surName;
  final String pesel;
  final String gender;
  final String birthDate;
  final int roleId;
  final int officeId;
  // var a, b;

  // User();
  User(this.firstName, this.middleName, this.surName, this.pesel, this.gender,
      this.birthDate, this.roleId, this.officeId);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        middleName = json['middleName'],
        surName = json['surName'],
        pesel = json['pesel'],
        gender = json['gender'],
        birthDate = json['birthDate'],
        roleId = json['roleId'],
        officeId = json['officeId'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'middleName': middleName,
        'surName': surName,
        'pesel': pesel,
        'gender': gender,
        'birthDate': birthDate,
        'roleId': roleId,
        'officeId': officeId,
      };
}
