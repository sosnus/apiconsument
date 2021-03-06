import 'package:apiconsument/data/role.dart';

class RolesCollection {
  RolesCollection();
  static List rolesCollection = [
    Role(1, "BOmanager", "BOmanager", "BOmanager"),
    Role(2, "HQmanager", "HQmanager", "HQmanager")
  ];

  static Role getRole(id) {
    return rolesCollection[id];
  }

  static Role getRoleAsString(id) {
    return rolesCollection[id].asString();
  }

  static List rolesList() {
    return rolesCollection;
  }

  static List rolesListString() {
    List list = [];
    rolesCollection.forEach((element) {
      list.add(element.toString());
    });
    return list;
  }
}
