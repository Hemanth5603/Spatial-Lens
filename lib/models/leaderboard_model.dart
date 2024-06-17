class LeaderboardModel {
  LeaderboardModel({
    this.leaderboard,
    this.status,
  });
  List<Leaderboard>? leaderboard;
  String? status;

  LeaderboardModel.fromJson(Map<String, dynamic> json) {
    leaderboard = List.from(json['leaderboard'])
        .map((e) => Leaderboard.fromJson(e))
        .toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['leaderboard'] = leaderboard?.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Leaderboard {
  Leaderboard({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.dob,
    required this.phone,
    required this.location,
    required this.contributions,
    required this.rank,
    required this.profileImage,
  });
  int? id;
  String? email;
  String? name;
  String? password;
  String? dob;
  String? phone;
  String? location;
  int? contributions;
  int? rank;
  String? profileImage;

  Leaderboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    dob = json['dob'];
    phone = json['phone'];
    location = json['location'];
    contributions = json['contributions'];
    rank = json['rank'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['name'] = name;
    _data['password'] = password;
    _data['dob'] = dob;
    _data['phone'] = phone;
    _data['location'] = location;
    _data['contributions'] = contributions;
    _data['rank'] = rank;
    _data['profile_image'];
    return _data;
  }
}
