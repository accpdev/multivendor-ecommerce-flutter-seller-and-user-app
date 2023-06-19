class OrderHistoryLogModel {
  String? status;
  String? userType;
  String? createdAt;
  OrderHistoryLogModel(
      {
        this.status,
        this.userType,
        this.createdAt,
        });

  OrderHistoryLogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userType = json['user_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    return data;
  }
}
