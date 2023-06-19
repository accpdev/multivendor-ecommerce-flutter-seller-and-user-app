class MessageBody {
  int? _userId;
  String? _message;

  MessageBody({int? sellerId, String? message}) {
    _userId = sellerId;
    _message = message;
  }

  int? get userId => _userId;
  String? get message => _message;

  MessageBody.fromJson(Map<String, dynamic> json) {
    _userId = json['id'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _userId;
    data['message'] = _message;
    return data;
  }
}
