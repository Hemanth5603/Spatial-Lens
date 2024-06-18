import 'package:flutter/widgets.dart';

class UserModel {
  UserModel(
      {this.email,
      this.id,
      this.name,
      this.status,
      this.phone,
      this.contributions,
      this.dob,
      this.location,
      this.rank,
      this.profile_image,
      this.longitude,
      this.latitude});
  String? email;
  int? id;
  String? name;
  String? status;
  String? phone;
  int? contributions;
  int? rank;
  String? dob;
  String? location;
  double? latitude;
  double? longitude;
  String? profile_image;

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    contributions = json['contributions'];
    rank = json['rank'];
    dob = json['dob'];
    location = json['location'];
    profile_image = json['profile_image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['id'] = id;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['contributions'] = contributions;
    _data['rank'] = rank;
    _data['dob'] = dob;
    _data['location'] = location;
    _data['status'] = status;
    _data['profile_image'] = profile_image;
    return _data;
  }
}
