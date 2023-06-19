class SellerBody {
  String? _sMethod;
  String? _fName;
  String? _lName;
  String? _bankName;
  String? _branch;
  String? _accountNo;
  String? _holderName;
  String? _password;
  String? _image;

  SellerBody(
      {String? sMethod,
        String? fName,
        String? lName,
        String? bankName,
        String? branch,
        String? accountNo,
        String? holderName,
        String? password,
        String? image}) {
    _sMethod = sMethod;
    _fName = fName;
    _lName = lName;
    _bankName = bankName;
    _branch = branch;
    _accountNo = accountNo;
    _holderName = holderName;
    _password = password;
    _image = image;
  }

  String? get sMethod => _sMethod;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get bankName => _bankName;
  String? get branch => _branch;
  String? get accountNo => _accountNo;
  String? get holderName => _holderName;
  String? get password => _password;
  String? get image => _image;

  SellerBody.fromJson(Map<String, dynamic> json) {
    _sMethod = json['_method'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _bankName = json['bank_name'];
    _branch = json['branch'];
    _accountNo = json['account_no'];
    _holderName = json['holder_name:'];
    _password = json['password'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_method'] = _sMethod;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['bank_name'] = _bankName;
    data['branch'] = _branch;
    data['account_no'] = _accountNo;
    data['holder_name:'] = _holderName;
    data['password'] = _password;
    data['image'] = _image;
    return data;
  }
}
