
import 'dart:convert';

import 'package:sixvalley_vendor_app/data/model/response/top_delivery_man.dart';


class OrderModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<Order>? orders;

  OrderModel({this.totalSize, this.limit, this.offset, this.orders});

  OrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Order {
  int? _id;
  int? _customerId;
  String? _customerType;
  String? _paymentStatus;
  String? _orderStatus;
  String? _paymentMethod;
  String? _transactionRef;
  double? _orderAmount;
  int? _shippingAddress;
  String? _shippingAddressData;
  int? _billingAddress;
  BillingAddressData? _billingAddressData;
  String? _createdAt;
  String? _updatedAt;
  double? _discountAmount;
  double? _shippingCost;
  String? _discountType;
  Customer? _customer;
  int? _deliveryManId;
  String? _orderNote;
  String? _orderType;
  Shipping? _shipping;
  double? _extraDiscount;
  String? _extraDiscountType;
  String? _deliveryType;
  String? _thirdPartyServiceName;
  String? _thirdPartyTrackingId;
  double? _deliverymanCharge;
  String? _expectedDeliveryDate;
  DeliveryMan? deliveryMan;

  Order(
      {int? id,
        int? customerId,
        String? customerType,
        String? paymentStatus,
        String? orderStatus,
        String? paymentMethod,
        String? transactionRef,
        double? orderAmount,
        int? shippingAddress,
        String? shippingAddressData,
        int? billingAddress,
        BillingAddressData? billingAddressData,
        double? shippingCost,
        String? createdAt,
        String? updatedAt,
        double? discountAmount,
        String? discountType,
        Customer? customer,
        int? deliveryManId,
        String? orderNote,
        String? orderType,
        Shipping? shipping,
        double? extraDiscount,
        String? extraDiscountType,
        String? deliveryType,
        String? thirdPartyServiceNam,
        String? thirdPartyTrackingId,
        double? deliverymanCharge,
        String? expectedDeliveryDate,
        DeliveryMan? deliveryMan,
      }) {
    _id = id;
    _customerId = customerId;
    _customerType = customerType;
    _paymentStatus = paymentStatus;
    _orderStatus = orderStatus;
    _paymentMethod = paymentMethod;
    _transactionRef = transactionRef;
    _orderAmount = orderAmount;
    _shippingAddress = shippingAddress;
    _shippingAddressData = shippingAddressData;
    _billingAddress = billingAddress;
    _billingAddressData = billingAddressData;
    _shippingCost = shippingCost;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _discountAmount = discountAmount;
    _discountType = discountType;
    _customer = customer;
    _deliveryManId = deliveryManId;
    _orderNote = orderNote;
    _orderType = orderType;
    if (shipping != null) {
      _shipping = shipping;
    }
    if (extraDiscount != null) {
      _extraDiscount = extraDiscount;
    }
    if (extraDiscountType != null) {
      _extraDiscountType = extraDiscountType;
    }
    if (deliveryType != null) {
      _deliveryType = deliveryType;
    }
    if (thirdPartyServiceNam != null) {
      _thirdPartyServiceName = thirdPartyServiceNam;
    }
    if (thirdPartyTrackingId != null) {
      _thirdPartyTrackingId = thirdPartyTrackingId;
    }
    _deliverymanCharge = deliverymanCharge;
    _expectedDeliveryDate = expectedDeliveryDate;
    if (deliveryMan != null) {
      this.deliveryMan = deliveryMan;
    }


  }

  // ignore: unnecessary_getters_setters
  int? get id => _id;
  // ignore: unnecessary_getters_setters
  set id(int? id) => _id = id;
  int? get customerId => _customerId;
  String? get customerType => _customerType;
  String? get paymentStatus => _paymentStatus;
  // ignore: unnecessary_getters_setters
  String? get orderStatus => _orderStatus;
  // ignore: unnecessary_getters_setters
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get paymentMethod => _paymentMethod;
  String? get transactionRef => _transactionRef;
  double? get orderAmount => _orderAmount;
  double? get shippingCost => _shippingCost;
  int? get shippingAddress => _shippingAddress;
  String? get shippingAddressData => _shippingAddressData;
  int? get billingAddress => _billingAddress;
  BillingAddressData? get billingAddressData => _billingAddressData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  double? get discountAmount => _discountAmount;
  String? get discountType => _discountType;
  Customer? get customer => _customer;
  int? get deliveryManId =>_deliveryManId;
  String? get orderNote => _orderNote;
  String? get orderType => _orderType;
  Shipping? get shipping => _shipping;
  double? get extraDiscount => _extraDiscount;
  String? get extraDiscountType => _extraDiscountType;
  String? get deliveryType => _deliveryType;
  String? get  thirdPartyServiceName => _thirdPartyServiceName;
  String? get  thirdPartyTrackingId => _thirdPartyTrackingId;
  double? get deliverymanCharge => _deliverymanCharge;
  String? get expectedDeliveryDate => _expectedDeliveryDate;


  Order.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _customerType = json['customer_type'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _paymentMethod = json['payment_method'];
    _transactionRef = json['transaction_ref'];
    if(json['order_amount'] != null){
      try{
        _orderAmount = json['order_amount'].toDouble();
      }catch(e){
        _orderAmount = double.parse(json['order_amount'].toString());
      }
    }
    if(json['shipping_cost'] != null){
      _shippingCost = json['shipping_cost'].toDouble();
    }

    _shippingAddress = json['shipping_address'];
    _shippingAddressData = json['shipping_address_data'];
    _billingAddress = json['billing_address'];
    if(json['billing_address_data'] != null){
      try{
        _billingAddressData =  BillingAddressData.fromJson(json['billing_address_data']);
      }catch(e){
        _billingAddressData =  BillingAddressData.fromJson(jsonDecode(json['billing_address_data']));
      }
    }

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if(json['delivery_man_id'] != null){
      _deliveryManId = json['delivery_man_id'];
    }

    if(json['discount_amount']!=null){
      _discountAmount = json['discount_amount'].toDouble();
    }

    _discountType = json['discount_type'];
    _customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    _orderNote = json['order_note'];
    _orderType = json['order_type'];
    _shipping = json['shipping'] != null
        ? Shipping.fromJson(json['shipping'])
        : null;
    if(json['extra_discount'] != null){
      _extraDiscount = json['extra_discount'].toDouble();
    }

    _extraDiscountType = json['extra_discount_type'];
    if(json['delivery_type']!=null && json['delivery_type']!= ""){
      _deliveryType = json['delivery_type'];
    }
    if(json['delivery_service_name']!=null && json['delivery_service_name']!= ""){
      _thirdPartyServiceName = json['delivery_service_name'];
    }
    if(json['third_party_delivery_tracking_id']!=null && json['third_party_delivery_tracking_id']!= ""){
      _thirdPartyTrackingId = json['third_party_delivery_tracking_id'];
    }
    if(json['deliveryman_charge'] != null){
      try{
        _deliverymanCharge = json['deliveryman_charge'].toDouble();
      }catch(e){
        _deliverymanCharge = double.parse(json['deliveryman_charge'].toString());
      }
    }

    _expectedDeliveryDate = json['expected_delivery_date'];
    deliveryMan = json['delivery_man'] != null
        ? DeliveryMan.fromJson(json['delivery_man'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['customer_id'] = _customerId;
    data['customer_type'] = _customerType;
    data['payment_status'] = _paymentStatus;
    data['order_status'] = _orderStatus;
    data['payment_method'] = _paymentMethod;
    data['transaction_ref'] = _transactionRef;
    data['order_amount'] = _orderAmount;
    data['shipping_address'] = _shippingAddress;
    data['shipping_address_data'] = shippingAddressData;
    data['billing_address'] = _billingAddress;
    if (billingAddressData != null) {
      data['billing_address_data'] = billingAddressData!.toJson();
    }
    data['shipping_cost'] = _shippingCost;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['delivery_man_id'] = _deliveryManId;
    data['discount_amount'] = _discountAmount;
    data['discount_type'] = _discountType;
    if (_customer != null) {
      data['customer'] = _customer!.toJson();
    }
    data['order_note'] = _orderNote;
    data['order_type'] = _orderType;
    if (_shipping != null) {
      data['shipping'] = _shipping!.toJson();
    }
    data['extra_discount'] = _extraDiscount;
    data['extra_discount_type'] = _extraDiscountType;
    data['delivery_type'] = _deliveryType;
    data['delivery_type'] = _deliveryType;
    data['delivery_service_name'] = _thirdPartyServiceName;
    data['third_party_delivery_tracking_id'] = _thirdPartyTrackingId;
    data['deliveryman_charge'] = _deliverymanCharge;
    data['expected_delivery_date'] = _expectedDeliveryDate;
    if (deliveryMan != null) {
      data['delivery_man'] = deliveryMan!.toJson();
    }
    return data;
  }
}

class Customer {
  int? _id;
  String? _name;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  String? _email;
  String? _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  String? _streetAddress;
  String? _country;
  String? _city;
  String? _zip;
  String? _houseNo;
  String? _apartmentNo;
  String? _cmFirebaseToken;
  DeliveryMan? _deliveryMan;

  Customer(
      {int? id,
        String? name,
        String? fName,
        String? lName,
        String? phone,
        String? image,
        String? email,
        String? emailVerifiedAt,
        String? createdAt,
        String? updatedAt,
        String? streetAddress,
        String? country,
        String? city,
        String? zip,
        String? houseNo,
        String? apartmentNo,
        String? cmFirebaseToken,
        DeliveryMan? deliveryMan,
      }) {
    _id = id;
    _name = name;
    _fName = fName;
    _lName = lName;
    _phone = phone;
    _image = image;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _streetAddress = streetAddress;
    _country = country;
    _city = city;
    _zip = zip;
    _houseNo = houseNo;
    _apartmentNo = apartmentNo;
    _cmFirebaseToken = cmFirebaseToken;
    if (deliveryMan != null) {
      _deliveryMan = deliveryMan;
    }
  }

  int? get id => _id;
  String? get name => _name;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  String? get email => _email;
  String? get emailVerifiedAt => _emailVerifiedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get streetAddress => _streetAddress;
  String? get country => _country;
  String? get city => _city;
  String? get zip => _zip;
  String? get houseNo => _houseNo;
  String? get apartmentNo => _apartmentNo;
  String? get cmFirebaseToken => _cmFirebaseToken;
  DeliveryMan? get deliveryMan => _deliveryMan;

  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    if(json['f_name']!=null){
      _fName = json['f_name'];
    }

    if(json['l_name']!=null){
      _lName = json['l_name'];
    }

    _phone = json['phone'];
    _image = json['image'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _streetAddress = json['street_address'];
    _country = json['country'];
    _city = json['city'];
    _zip = json['zip'];
    _houseNo = json['house_no'];
    _apartmentNo = json['apartment_no'];
    _cmFirebaseToken = json['cm_firebase_token'];
    _deliveryMan = json['delivery_man'] != null
        ? DeliveryMan.fromJson(json['delivery_man'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['image'] = _image;
    data['email'] = _email;
    data['email_verified_at'] = _emailVerifiedAt;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['street_address'] = _streetAddress;
    data['country'] = _country;
    data['city'] = _city;
    data['zip'] = _zip;
    data['house_no'] = _houseNo;
    data['apartment_no'] = _apartmentNo;
    data['cm_firebase_token'] = _cmFirebaseToken;
    if (_deliveryMan != null) {
      data['delivery_man'] = _deliveryMan!.toJson();
    }
    return data;
  }
}


class BillingAddressData {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;

  BillingAddressData(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling});

  BillingAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    return data;
  }
}

class Shipping {
  int? _id;
  int? _creatorId;
  String? _creatorType;
  String? _title;
  double? _cost;
  String? _duration;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  Shipping(
      {int? id,
        int? creatorId,
        String? creatorType,
        String? title,
        double? cost,
        String? duration,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (creatorId != null) {
      _creatorId = creatorId;
    }
    if (creatorType != null) {
      _creatorType = creatorType;
    }
    if (title != null) {
      _title = title;
    }
    if (cost != null) {
      _cost = cost;
    }
    if (duration != null) {
      _duration = duration;
    }
    if (status != null) {
      _status = status;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  int? get creatorId => _creatorId;
  String? get creatorType => _creatorType;
  String? get title => _title;
  double? get cost => _cost;
  String? get duration => _duration;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  Shipping.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _creatorId = json['creator_id'];
    _creatorType = json['creator_type'];
    _title = json['title'];
    _cost = json['cost'].toDouble();
    _duration = json['duration'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['creator_id'] = _creatorId;
    data['creator_type'] = _creatorType;
    data['title'] = _title;
    data['cost'] = _cost;
    data['duration'] = _duration;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

