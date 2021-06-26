class Office {
  final int id; // key
  final String city;
  final String type;

  Office(this.id, this.city, this.type);

  Office.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "ERROR",
        city = json['city'] ?? "ERROR",
        type = json['type'] ?? "ERROR";

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'type': type,
      };

  @override
  String toString() {
    return this.toJson().toString();
  }

  static obj(offic) {}
}
