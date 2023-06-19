import 'package:sixvalley_vendor_app/data/model/response/cart_model.dart';

class TemporaryCartListModel {
  List<CartModel>? _cart;
  int? _userId;
  String? _customerName;
  int? _userIndex;
  double? _customerBalance;
  double? _couponAmount;
  String? couponCode;
  double? _extraDiscount;



  TemporaryCartListModel(
      {List<CartModel>? cart,
        int? userId,
        String? customerName,
        int? userIndex,
        double? customerBalance,
        double? couponAmount,
        String? couponCode,
        double? extraDiscount,
      }) {
    _cart = cart;
    _userId = userId;
    _customerName = customerName;
    _userIndex = userIndex;
    _customerBalance = customerBalance;
    _couponAmount = couponAmount;
    _extraDiscount = extraDiscount;

  }

  List<CartModel>? get cart => _cart;
  int? get userId => _userId;
  String? get customerName => _customerName;
  int? get userIndex => _userIndex;
  double? get customerBalance => _customerBalance;
  // ignore: unnecessary_getters_setters
  double? get couponAmount => _couponAmount;
  // ignore: unnecessary_getters_setters
  double? get extraDiscount => _extraDiscount;


  set couponAmount(double? value) {
    _couponAmount = value;
  }


  set extraDiscount(double? value) {
    _extraDiscount = value;
  }

  TemporaryCartListModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart!.add(CartModel.fromJson(v));
      });
    }
    _userId = json['user_id'];
    _userIndex = json['user_index'];
    _customerName = json['customer_name'];
    _customerBalance = json['customer_balance'];
    couponCode = json['coupon_code'];
    _couponAmount = json['coupon_discount_amount'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_cart != null) {
      data['cart'] = _cart!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = _userId;
    data['user_index'] = _userIndex;
    data['customer_name'] = _customerName;
    data['customer_balance'] = _customerName;
    data['coupon_code'] = couponCode;
    data['coupon_discount_amount'] = _couponAmount;


    return data;
  }


}

class Cart {
  String? _productId;
  String? _price;
  double? _discountAmount;
  int? _quantity;
  double? _taxAmount;


  Cart(
      String productId,
      String price,
      double discountAmount,
      int quantity,
      double taxAmount,
      ) {
    _productId = productId;
    _price = price;
    _discountAmount = discountAmount;
    _quantity = quantity;
    _taxAmount = taxAmount;

  }

  String? get productId => _productId;
  String? get price => _price;
  double? get discountAmount => _discountAmount;
  int? get quantity => _quantity;
  double? get taxAmount => _taxAmount;


  Cart.fromJson(Map<String, dynamic> json) {
    _productId = json['id'];
    _price = json['price'];
    _discountAmount = json['discount'];
    _quantity = json['quantity'];
    _taxAmount = json['tax'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _productId;
    data['price'] = _price;
    data['discount'] = _discountAmount;
    data['quantity'] = _quantity;
    data['tax'] = _taxAmount;
    return data;
  }
}



