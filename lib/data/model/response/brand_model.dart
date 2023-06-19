class BrandModel {
  int? _id;
  String? _name;
  String? _image;

  BrandModel(
      {int? id,
        String? name,
        String? image}) {
    _id = id;
    _name = name;
    _image = image;
  }

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;

  BrandModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['image'] = _image;
    return data;
  }
}
