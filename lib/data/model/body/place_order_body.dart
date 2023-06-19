import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class PlaceOrderBody {
  List<Cart>? _cart;
  double? _couponDiscountAmount;
  double? _orderAmount;
  String? _couponCode;
  double? _couponAmount;
  int? _userId;
  double? _extraDiscount;
  String? _extraDiscountType;
  String? _paymentMethod;




  PlaceOrderBody(
      {required List<Cart> cart,
        double? couponDiscountAmount,
        String? couponCode,
        double? couponAmount,
        double? orderAmount,
        int? userId,
        double? extraDiscount,
        String? extraDiscountType,
        String? paymentMethod,


       }) {
    _cart = cart;
    _couponDiscountAmount = couponDiscountAmount;
    _couponCode = couponCode;
    _couponAmount = couponAmount;
    _orderAmount = orderAmount;
    _userId = userId;
    _extraDiscount = extraDiscount;
    _extraDiscountType = extraDiscountType;
    _paymentMethod = paymentMethod;

  }

  List<Cart>? get cart => _cart;
  double? get couponDiscountAmount => _couponDiscountAmount;
  String? get couponCode => _couponCode;
  double? get couponAmount => _couponAmount;
  double? get orderAmount => _orderAmount;
  int? get userId => _userId;
  double? get extraDiscount => _extraDiscount;
  String? get extraDiscountType => _extraDiscountType;
  String? get paymentMethod => _paymentMethod;


  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart!.add(Cart.fromJson(v));
      });
    }
    _couponDiscountAmount = json['coupon_discount'];
    _couponCode = json['coupon_code'];
    _couponAmount = json['coupon_discount_amount'];
    _orderAmount = json['order_amount'];
    _userId = json['customer_id'];
    _extraDiscount = json['extra_discount'];
    _extraDiscountType = json ['extra_discount_type'];
    _paymentMethod = json ['payment_method'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_cart != null) {
      data['cart'] = _cart!.map((v) => v.toJson()).toList();
    }
    data['coupon_discount'] = _couponDiscountAmount;
    data['order_amount'] = _orderAmount;
    data['coupon_code'] = _couponCode;
    data['coupon_discount_amount'] = _couponAmount;
    data['customer_id'] = _userId;
    data['extra_discount'] = _extraDiscount;
    data['extra_discount_type'] = _extraDiscountType;
    data['payment_method'] = _paymentMethod;

    return data;
  }
}

class Cart {
  String? _productId;
  String? _price;
  double? _discountAmount;
  int? _quantity;
  String? _variant;
  List<Variation?>? _variation;




  Cart(
      String productId,
      String price,
      double discountAmount,
      int? quantity,
      String? variant,
      List<Variation?> variation


      ) {
    _productId = productId;
    _price = price;
    _discountAmount = discountAmount;
    _quantity = quantity;
    _variant = variant;
    _variation = variation;



  }

  String? get productId => _productId;
  String? get price => _price;
  double? get discountAmount => _discountAmount;
  int? get quantity => _quantity;
  String? get variant => _variant;
  List<Variation?>? get variation => _variation;



  Cart.fromJson(Map<String, dynamic> json) {
    _productId = json['id'];
    _price = json['price'];
    _discountAmount = json['discount'];
    _quantity = json['quantity'];
    _variant = json['variant'];
    if (json['variation'] != null) {
      _variation = <Variation>[];
      json['variation'].forEach((v) {
        _variation!.add(Variation.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _productId;
    data['price'] = _price;
    data['discount'] = _discountAmount;
    data['quantity'] = _quantity;
    data['variant'] = _variant;
    if (_variation != null) {
      data['variation'] = _variation!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}
