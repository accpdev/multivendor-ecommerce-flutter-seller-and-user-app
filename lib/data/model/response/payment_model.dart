class PaymentModel {
  final String _name;
  final double _amount;
  PaymentModel(this._name, this._amount);

  String get name => _name;
  double get amount => _amount;
}