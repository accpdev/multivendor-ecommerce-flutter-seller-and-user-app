class OrderDetailsModel {
  int? _id;
  int? _orderId;
  int? _productId;
  int? _sellerId;
  String? _digitalFileAfterSell;
  ProductDetails? _productDetails;
  int? _qty;
  double? _price;
  double? _tax;
  String? _taxModel;
  double? _discount;
  String? _deliveryStatus;
  String? _paymentStatus;
  String? _createdAt;
  String? _updatedAt;
  int? _shippingMethodId;
  String? _variant;
  String? _variation;
  String? _discountType;
  Shipping? _shipping;

  OrderDetailsModel(
      {int? id,
        int? orderId,
        int? productId,
        int? sellerId,
        String? digitalFileAfterSell,
        ProductDetails? productDetails,
        int? qty,
        double? price,
        double? tax,
        String? taxModel,
        double? discount,
        String? deliveryStatus,
        String? paymentStatus,
        String? createdAt,
        String? updatedAt,
        int? shippingMethodId,
        String? variant,
        String? variation,
        String? discountType,
        Shipping? shipping}) {
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _sellerId = sellerId;
    _digitalFileAfterSell = digitalFileAfterSell;
    _productDetails = productDetails;
    _qty = qty;
    _price = price;
    _tax = tax;
    _taxModel = taxModel;
    _discount = discount;
    _deliveryStatus = deliveryStatus;
    _paymentStatus = paymentStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _shippingMethodId = shippingMethodId;
    _variant = variant;
    _variation = variation;
    _discountType = discountType;
    _shipping = shipping;
  }

  int? get id => _id;
  // ignore: unnecessary_getters_setters
  int? get orderId => _orderId;

  // ignore: unnecessary_getters_setters
  set orderId(int? orderId) => _orderId = orderId;
  int? get productId => _productId;
  int? get sellerId => _sellerId;
  String? get digitalFileAfterSell  => _digitalFileAfterSell;
  ProductDetails? get productDetails => _productDetails;
  int? get qty => _qty;
  double? get price => _price;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  double? get discount => _discount;
  // ignore: unnecessary_getters_setters
  String? get deliveryStatus => _deliveryStatus;
  // ignore: unnecessary_getters_setters
  set deliveryStatus(String? deliveryStatus) => _deliveryStatus = deliveryStatus;
  String? get paymentStatus => _paymentStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get shippingMethodId => _shippingMethodId;
  String? get variant => _variant;
  String? get variation => _variation;
  String? get discountType => _discountType;
  Shipping? get shipping => _shipping;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _sellerId = json['seller_id'];
    _digitalFileAfterSell = json['digital_file_after_sell'];
    _productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
    _qty = json['qty'];
    if(json['price']!=null){
      _price = json['price'].toDouble();
    }

    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _discount = json['discount'].toDouble();
    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shippingMethodId = json['shipping_method_id'];
    _variant = json['variant'];
    _variation = json['variation'];
    _discountType = json['discount_type'];
    _shipping = json['shipping'] != null
        ? Shipping.fromJson(json['shipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['order_id'] = _orderId;
    data['product_id'] = _productId;
    data['seller_id'] = _sellerId;
    data['digital_file_after_sell'] = _digitalFileAfterSell;
    if (_productDetails != null) {
      data['product_details'] = _productDetails!.toJson();
    }
    data['qty'] = _qty;
    data['price'] = _price;
    data['tax'] = _tax;
    data['tax_model'] = _taxModel;
    data['discount'] = _discount;
    data['delivery_status'] = _deliveryStatus;
    data['payment_status'] = _paymentStatus;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['shipping_method_id'] = _shippingMethodId;
    data['variant'] = _variant;
    data['variation'] = _variation;
    data['discount_type'] = _discountType;
    if (_shipping != null) {
      data['shipping'] = _shipping!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  int? _id;
  String? _addedBy;
  int? _userId;
  String? _name;
  String? _productType;
  List<CategoryIds>? _categoryIds;
  int? _brandId;
  String? _unit;
  int? _minQty;
  List<String>? _images;
  String? _thumbnail;
  List<Colores>? _colors;
  List<ChoiceOptions>? _choiceOptions;
  List<Variation>? _variation;
  double? _unitPrice;
  double? _purchasePrice;
  double? _tax;
  String? _taxModel;
  String? _taxType;
  double? _discount;
  String? _discountType;
  int? _currentStock;
  String? _details;
  int? _freeShipping;
  String? _createdAt;
  String? _updatedAt;
  String? _digitalProductType;
  String? _digitalFileReady;

  ProductDetails(
      {int? id,
        String? addedBy,
        int? userId,
        String? name,
        String? productType,
        List<CategoryIds>? categoryIds,
        int? brandId,
        String? unit,
        int? minQty,
        List<String>? images,
        String? thumbnail,
        List<Colores>? colors,
        List<String>? attributes,
        List<ChoiceOptions>? choiceOptions,
        List<Variation>? variation,
        double? unitPrice,
        double? purchasePrice,
        double? tax,
        String? taxModel,
        String? taxType,
        double? discount,
        String? discountType,
        int? currentStock,
        String? details,
        String? createdAt,
        String? updatedAt,
        String? digitalProductType,
        String? digitalFileReady,
      }) {
    _id = id;
    _addedBy = addedBy;
    _userId = userId;
    _name = name;
    _productType = productType;
    _categoryIds = categoryIds;
    _brandId = brandId;
    _unit = unit;
    _minQty = minQty;
    _images = images;
    _thumbnail = thumbnail;
    _colors = colors;
    _choiceOptions = choiceOptions;
    _variation = variation;
    _unitPrice = unitPrice;
    _purchasePrice = purchasePrice;
    _tax = tax;
    _taxModel = taxModel;
    _taxType = taxType;
    _discount = discount;
    _discountType = discountType;
    _currentStock = currentStock;
    _details = details;
    _freeShipping = freeShipping;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    if (digitalProductType != null) {
      _digitalProductType = digitalProductType;
    }
    if (digitalFileReady != null) {
      _digitalFileReady = digitalFileReady;
    }
  }

  int? get id => _id;
  String? get addedBy => _addedBy;
  int? get userId => _userId;
  String? get name => _name;
  String? get productType => _productType;
  List<CategoryIds>? get categoryIds => _categoryIds;
  int? get brandId => _brandId;
  String? get unit => _unit;
  int? get minQty => _minQty;
  List<String>? get images => _images;
  String? get thumbnail => _thumbnail;
  List<Colores>? get colors => _colors;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<Variation>? get variation => _variation;
  double? get unitPrice => _unitPrice;
  double? get purchasePrice => _purchasePrice;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  String? get taxType => _taxType;
  double? get discount => _discount;
  String? get discountType => _discountType;
  int? get currentStock => _currentStock;
  String? get details => _details;
  int? get freeShipping => _freeShipping;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get digitalProductType => _digitalProductType;
  String? get digitalFileReady => _digitalFileReady;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _name = json['name'];
    _productType = json['product_type'];
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    _brandId = json['brand_id'];
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _images = json['images'].cast<String>();
    _thumbnail = json['thumbnail'];
    if (json['colors_formatted'] != null) {
      _colors = [];
      json['colors_formatted'].forEach((v) {
        _colors!.add(Colores.fromJson(v));
      });
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation!.add(Variation.fromJson(v));
      });
    }
    _unitPrice = json['unit_price'].toDouble();
    _purchasePrice = json['purchase_price'].toDouble();
    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _taxType = json['tax_type'];
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    _details = json['details'];
    _freeShipping = json['free_shipping'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if(json['digital_product_type']!=null){
      _digitalProductType = json['digital_product_type'];
    }
    if(json['digital_file_ready']!=null){
      _digitalFileReady = json['digital_file_ready'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['added_by'] = _addedBy;
    data['user_id'] = _userId;
    data['name'] = _name;
    data['product_type'] = productType;
    if (_categoryIds != null) {
      data['category_ids'] = _categoryIds!.map((v) => v.toJson()).toList();
    }
    data['brand_id'] = _brandId;
    data['unit'] = _unit;
    data['min_qty'] = _minQty;
    data['images'] = _images;
    data['thumbnail'] = _thumbnail;
    if (_colors != null) {
      data['colors_formatted'] = _colors!.map((v) => v.toJson()).toList();
    }
    if (_choiceOptions != null) {
      data['choice_options'] =
          _choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (_variation != null) {
      data['variation'] = _variation!.map((v) => v.toJson()).toList();
    }
    data['unit_price'] = _unitPrice;
    data['purchase_price'] = _purchasePrice;
    data['tax'] = _tax;
    data['tax_model'] = _taxModel;
    data['tax_type'] = _taxType;
    data['discount'] = _discount;
    data['discount_type'] = _discountType;
    data['current_stock'] = _currentStock;
    data['details'] = _details;
    data['free_shipping'] = _freeShipping;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['digital_product_type'] = digitalProductType;
    data['digital_file_ready'] = digitalFileReady;
    return data;
  }
}

class CategoryIds {
  String? _id;
  int? _position;

  CategoryIds({String? id, int? position}) {
    _id = id;
    _position = position;
  }

  String? get id => _id;
  int? get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['position'] = _position;
    return data;
  }
}

class Colores {
  String? _name;
  String? _code;

  Colores({String? name, String? code}) {
    _name = name;
    _code = code;
  }

  String? get name => _name;
  String? get code => _code;

  Colores.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['code'] = _code;
    return data;
  }
}

class ChoiceOptions {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOptions({String? name, String? title, List<String>? options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['title'] = _title;
    data['options'] = _options;
    return data;
  }
}

class Variation {
  String? _type;
  double? _price;
  String? _sku;
  int? _qty;

  Variation({String? type, double? price, String? sku, int? qty}) {
    _type = type;
    _price = price;
    _sku = sku;
    _qty = qty;
  }

  String? get type => _type;
  double? get price => _price;
  String? get sku => _sku;
  int? get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['price'] = _price;
    data['sku'] = _sku;
    data['qty'] = _qty;
    return data;
  }
}

class Shipping {
  int? _id;
  int? _creatorId;
  String? _creatorType;
  String? _title;
  int? _cost;
  String? _duration;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  Shipping(
      {int? id,
        int? creatorId,
        String? creatorType,
        String? title,
        int? cost,
        String? duration,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    _id = id;
    _creatorId = creatorId;
    _creatorType = creatorType;
    _title = title;
    _cost = cost;
    _duration = duration;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  int? get creatorId => _creatorId;
  String? get creatorType => _creatorType;
  String? get title => _title;
  int? get cost => _cost;
  String? get duration => _duration;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Shipping.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _creatorId = json['creator_id'];
    _creatorType = json['creator_type'];
    _title = json['title'];
    _cost = json['cost'];
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
