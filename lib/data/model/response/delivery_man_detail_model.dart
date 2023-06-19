class DeliveryManDetails {
  DeliveryMan? deliveryMan;
  double? withdrawbaleBalance;

  DeliveryManDetails({this.deliveryMan, this.withdrawbaleBalance});

  DeliveryManDetails.fromJson(Map<String, dynamic> json) {
    deliveryMan = json['delivery_man'] != null
        ? DeliveryMan.fromJson(json['delivery_man'])
        : null;

    if(json['withdrawbale_balance'] != null){
      withdrawbaleBalance = json['withdrawbale_balance'].toDouble();
    }else{
      withdrawbaleBalance = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliveryMan != null) {
      data['delivery_man'] = deliveryMan!.toJson();
    }
    data['withdrawbale_balance'] = withdrawbaleBalance;
    return data;
  }
}

class DeliveryMan {
  int? id;
  String? fName;
  String? lName;
  String? address;
  String? countryCode;
  String? phone;
  String? email;
  String? image;
  String? bankName;
  String? branch;
  String? accountNo;
  String? holderName;
  int? isActive;
  int? isOnline;
  Wallet? wallet;



  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.address,
        this.countryCode,
        this.phone,
        this.email,
        this.image,
        this.bankName,
        this.branch,
        this.accountNo,
        this.holderName,
        this.isActive,
        this.isOnline,
        this.wallet,
        });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    address = json['address'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    isActive = json['is_active'];
    isOnline = json['is_online'];
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['address'] = address;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['bank_name'] = bankName;
    data['branch'] = branch;
    data['account_no'] = accountNo;
    data['holder_name'] = holderName;
    data['is_active'] = isActive;
    data['is_online'] = isOnline;
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? id;
  int? deliveryManId;
  String? currentBalance;
  String? cashInHand;
  String? pendingWithdraw;
  String? totalWithdraw;
  String? createdAt;
  String? updatedAt;

  Wallet(
      {this.id,
        this.deliveryManId,
        this.currentBalance,
        this.cashInHand,
        this.pendingWithdraw,
        this.totalWithdraw,
        this.createdAt,
        this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = json['delivery_man_id'];
    currentBalance = json['current_balance'];
    cashInHand = json['cash_in_hand'];
    pendingWithdraw = json['pending_withdraw'];
    totalWithdraw = json['total_withdraw'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['delivery_man_id'] = deliveryManId;
    data['current_balance'] = currentBalance;
    data['cash_in_hand'] = cashInHand;
    data['pending_withdraw'] = pendingWithdraw;
    data['total_withdraw'] = totalWithdraw;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Rating {
  String? average;
  int? deliveryManId;

  Rating({this.average, this.deliveryManId});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    deliveryManId = json['delivery_man_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    data['delivery_man_id'] = deliveryManId;
    return data;
  }
}
