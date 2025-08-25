class ProfileModel {
  int? id;
  String? name;
  String? image64bit;
  String? timestamp;

  ProfileModel({this.id, this.name, this.image64bit, this.timestamp});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "image64bit": image64bit,
      "timestamp": timestamp,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
    id: map["id"],
    name: map["name"],
    image64bit: map["image64bit"],
    timestamp: map["timestamp"],
  );
}
