class ShopModel {
  int? id;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? banner;
  String? bottomBanner;
  double? ratting;
  int? rattingCount;
  int? temporaryClose;
  String? vacationEndDate;
  String? vacationStartDate;
  int? vacationStatus;



  ShopModel(
      {this.id,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.banner,
        this.bottomBanner,
        this.ratting,
        this.rattingCount,
        this.temporaryClose,
        this.vacationEndDate,
        this.vacationStartDate,
        this.vacationStatus
      });

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    bottomBanner = json['bottom_banner'];
    ratting = json['rating'].toDouble();
    rattingCount = json['rating_count'];
    temporaryClose = json['temporary_close'] != null? int.parse(json['temporary_close'].toString()) : 0;
    vacationEndDate = json['vacation_end_date'];
    vacationStartDate = json['vacation_start_date'];
    vacationStatus = json['vacation_status'] != null? int.parse(json['vacation_status'].toString()): 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['contact'] = contact;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['banner'] = banner;
    data['rating'] = ratting;
    data['rating_count'] = rattingCount;
    data['temporary_close'] = temporaryClose;
    data['vacation_end_date'] = vacationEndDate;
    data['vacation_start_date'] = vacationStartDate;
    data['vacation_status'] = vacationStatus;

    return data;
  }
}
