class ActivityModel {
  ActivityModel({
    this.data,
    this.status,
  });
  List<Data>? data;
  String? status;

  ActivityModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data?.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data(
      {required this.Id,
      required this.Latitude,
      required this.Longitude,
      required this.Image,
      required this.Category,
      required this.Remarks,
      required this.address,
      required this.date,
      required this.time,
      required this.dataId,
      required this.isApproved});
  int? Id;
  double? Latitude;
  double? Longitude;
  String? Image;
  String? Category;
  String? Remarks;
  String? address;
  String? time;
  String? date;
  int? isApproved;
  int? dataId;

  Data.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    Image = json['Image'];
    Category = json['Category'];
    Remarks = json['Remarks'];
    address = json['Address'];
    time = json['Time'];
    date = json['Date'];
    isApproved = json['IsApproved'];
    dataId = json['DateId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['address'] = address;
    _data['Latitude'] = Latitude;
    _data['Longitude'] = Longitude;
    _data['Image'] = Image;
    _data['Category'] = Category;
    _data['Remarks'] = Remarks;

    return _data;
  }
}
