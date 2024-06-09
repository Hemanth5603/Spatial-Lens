class UserModel {
  UserModel({
    this.email,
    this.id,
    this.name,
    this.status,
  });
  String? email;
  int? id;
  String? name;
  String? status;

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    return _data;
  }
}
