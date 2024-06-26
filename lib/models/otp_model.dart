class OTPModel {
  OTPModel({
    this.requestId,
    this.status,
    this.statusCode,
  });
  String? requestId;
  String? status;
  String? statusCode;

  OTPModel.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    status = json['status'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['request_id'] = requestId;
    _data['status'] = status;
    _data['status_code'] = statusCode;
    return _data;
  }
}
