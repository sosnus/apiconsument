class Office {
  final int id; // key
  final String city;
  final String type;

  Office(this.id, this.city, this.type);

  Office.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        city = json['city'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'type': type,
      };

  @override
  String toString() {
    return this.toJson().toString();
  }

  // Widget toWidgetCard() {
  //           return Card(
  //         elevation: 4,
  //         child: ListTile(
  //           title: Text(
  //             posts[index]['city'],
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           subtitle: Text(posts[index]['type']),
  //           onTap: () => _navigateToPost(context, posts[index]['id']),
  //         ),
  //       );
  // }

  static obj(offic) {}
}
