class User {
  var firstName;
  var middleName;
  var surName;
  var pesel;
  var gender;
  var birthDate;
  var roleId;
  var officeId;
  // var a, b;

  // User();
  User(firstName, middleName, surName, pesel, gender, birthDate, roleId,
      officeId) {
    this.firstName = firstName;
    this.middleName = middleName;
    this.surName = surName;
    this.pesel = pesel;
    this.gender = gender;
    this.birthDate = birthDate;
    this.roleId = roleId;
    this.officeId = officeId;
  }
}
