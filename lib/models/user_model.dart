class UserModel {
  UserModel({this.id, this.name, this.status, this.latitude, this.longitude});
  int? id;
  String? name;
  String? status;
  double? latitude;
  double? longitude;
  String? email;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['email'] = email;
    return _data;
  }
}
