class SellerModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? password;
  String? status;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? bankName;
  String? branch;
  String? accountNo;
  String? holderName;
  String? authToken;
  double? salesCommissionPercentage;
  String? gst;
  int? productCount;
  int? ordersCount;
  Wallet? wallet;

  SellerModel(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
        this.password,
        this.status,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.bankName,
        this.branch,
        this.accountNo,
        this.holderName,
        this.authToken,
        this.salesCommissionPercentage,
        this.gst,
        this.productCount,
        this.ordersCount,
        this.wallet});

  SellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    authToken = json['auth_token'];
    if(json['sales_commission_percentage']!=null){
      try{
        salesCommissionPercentage = (json['sales_commission_percentage']).toDouble();
      }catch(e){
        salesCommissionPercentage = double.parse(json['sales_commission_percentage'].toString());
      }


    }
    if(json['gst']!=null){
      gst = json['gst'];
    }
    productCount = json['product_count'];
    ordersCount = json['orders_count'];
    wallet =
    json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bank_name'] = bankName;
    data['branch'] = branch;
    data['account_no'] = accountNo;
    data['holder_name'] = holderName;
    data['auth_token'] = authToken;
    data['sales_commission_percentage'] = salesCommissionPercentage;
    data['gst'] = gst;
    data['product_count'] = productCount;
    data['orders_count'] = ordersCount;
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? id;
  double? totalEarning;
  double? withdrawn;
  String? createdAt;
  String? updatedAt;
  double? commissionGiven;
  double? pendingWithdraw;
  double? deliveryChargeEarned;
  double? collectedCash;
  double? totalTaxCollected;

  Wallet(
      {this.id,
        this.totalEarning,
        this.withdrawn,
        this.createdAt,
        this.updatedAt,
        this.commissionGiven,
        this.pendingWithdraw,
        this.deliveryChargeEarned,
        this.collectedCash,
        this.totalTaxCollected});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalEarning = json['total_earning'].toDouble();
    withdrawn = json['withdrawn'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commissionGiven = json['commission_given'].toDouble();
    pendingWithdraw = json['pending_withdraw'].toDouble();
    deliveryChargeEarned = json['delivery_charge_earned'].toDouble();
    collectedCash = json['collected_cash'].toDouble();
    totalTaxCollected = json['total_tax_collected'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_earning'] = totalEarning;
    data['withdrawn'] = withdrawn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['commission_given'] = commissionGiven;
    data['pending_withdraw'] = pendingWithdraw;
    data['delivery_charge_earned'] = deliveryChargeEarned;
    data['collected_cash'] = collectedCash;
    data['total_tax_collected'] = totalTaxCollected;
    return data;
  }
}
