class CategoryWiseShippingModel {
  List<AllCategoryShippingCost>? allCategoryShippingCost;

  CategoryWiseShippingModel({this.allCategoryShippingCost});

  CategoryWiseShippingModel.fromJson(Map<String, dynamic> json) {
    if (json['all_category_shipping_cost'] != null) {
      allCategoryShippingCost = <AllCategoryShippingCost>[];
      json['all_category_shipping_cost'].forEach((v) {
        allCategoryShippingCost!.add(AllCategoryShippingCost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allCategoryShippingCost != null) {
      data['all_category_shipping_cost'] =
          allCategoryShippingCost!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCategoryShippingCost {
  int? id;
  int? sellerId;
  int? categoryId;
  double? cost;
  int? multiplyQty;
  String? createdAt;
  String? updatedAt;
  Category? category;

  AllCategoryShippingCost(
      {this.id,
        this.sellerId,
        this.categoryId,
        this.cost,
        this.multiplyQty,
        this.createdAt,
        this.updatedAt,
        this.category});

  AllCategoryShippingCost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    categoryId = json['category_id'];
    cost = json['cost'].toDouble();
    if(json['multiply_qty']!=null){
      multiplyQty = int.parse(json['multiply_qty'].toString());
    }else{
      multiplyQty = 0;
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['category_id'] = categoryId;
    data['cost'] = cost;
    data['multiply_qty'] = multiplyQty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;
  int? priority;


  Category(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.parentId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.homeStatus,
        this.priority,
        });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if(json['name']!=null){
      name = json['name'];
    }else{
      name = '';
    }
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    priority = json['priority'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['home_status'] = homeStatus;
    data['priority'] = priority;
    return data;
  }
}
