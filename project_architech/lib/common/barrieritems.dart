class BarrierItemsModel {
  String? _barrierCode, _delayhrs, _description;

  BarrierItemsModel(this._barrierCode, this._delayhrs, this._description);

  get description => _description;

  set description(value) {
    _description = value;
  }

  get delayhrs => _delayhrs;

  set delayhrs(value) {
    _delayhrs = value;
  }

  String? get barrierCode => _barrierCode;

  set barrierCode(String? value) {
    _barrierCode = value;
  }

/*String? get barrierCode => _barrierCode;

  set barrierCode(String value) {
    _barrierCode = value;
  }*/
}
