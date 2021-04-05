// GENERATED CODE - DO NOT MODIFY BY HAND

part of phone_store;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PhoneStore on PhoneStoreBase, Store {
  final _$dialCodeListAtom = Atom(name: 'PhoneStoreBase.dialCodeList');

  @override
  ObservableList<String> get dialCodeList {
    _$dialCodeListAtom.reportRead();
    return super.dialCodeList;
  }

  @override
  set dialCodeList(ObservableList<String> value) {
    _$dialCodeListAtom.reportWrite(value, super.dialCodeList, () {
      super.dialCodeList = value;
    });
  }

  final _$dialCodeAtom = Atom(name: 'PhoneStoreBase.dialCode');

  @override
  String get dialCode {
    _$dialCodeAtom.reportRead();
    return super.dialCode;
  }

  @override
  set dialCode(String value) {
    _$dialCodeAtom.reportWrite(value, super.dialCode, () {
      super.dialCode = value;
    });
  }

  final _$phoneNumberAtom = Atom(name: 'PhoneStoreBase.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  final _$validatedPhoneNumberAtom =
      Atom(name: 'PhoneStoreBase.validatedPhoneNumber');

  @override
  ObservableList<String> get validatedPhoneNumber {
    _$validatedPhoneNumberAtom.reportRead();
    return super.validatedPhoneNumber;
  }

  @override
  set validatedPhoneNumber(ObservableList<String> value) {
    _$validatedPhoneNumberAtom.reportWrite(value, super.validatedPhoneNumber,
        () {
      super.validatedPhoneNumber = value;
    });
  }

  final _$statusCodeAtom = Atom(name: 'PhoneStoreBase.statusCode');

  @override
  int get statusCode {
    _$statusCodeAtom.reportRead();
    return super.statusCode;
  }

  @override
  set statusCode(int value) {
    _$statusCodeAtom.reportWrite(value, super.statusCode, () {
      super.statusCode = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'PhoneStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loadJsonAsyncAction = AsyncAction('PhoneStoreBase.loadJson');

  @override
  Future<void> loadJson() {
    return _$loadJsonAsyncAction.run(() => super.loadJson());
  }

  final _$loadRecordAsyncAction = AsyncAction('PhoneStoreBase.loadRecord');

  @override
  Future<void> loadRecord() {
    return _$loadRecordAsyncAction.run(() => super.loadRecord());
  }

  final _$validatePhoneNumberAsyncAction =
      AsyncAction('PhoneStoreBase.validatePhoneNumber');

  @override
  Future<int> validatePhoneNumber() {
    return _$validatePhoneNumberAsyncAction
        .run(() => super.validatePhoneNumber());
  }

  final _$saveValidatedPhoneNumberAsyncAction =
      AsyncAction('PhoneStoreBase.saveValidatedPhoneNumber');

  @override
  Future<void> saveValidatedPhoneNumber(String dialCode, String phoneNumber) {
    return _$saveValidatedPhoneNumberAsyncAction
        .run(() => super.saveValidatedPhoneNumber(dialCode, phoneNumber));
  }

  final _$PhoneStoreBaseActionController =
      ActionController(name: 'PhoneStoreBase');

  @override
  List<CountryDialCode> parseJson(String response) {
    final _$actionInfo = _$PhoneStoreBaseActionController.startAction(
        name: 'PhoneStoreBase.parseJson');
    try {
      return super.parseJson(response);
    } finally {
      _$PhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDialCode(String dialCode) {
    final _$actionInfo = _$PhoneStoreBaseActionController.startAction(
        name: 'PhoneStoreBase.setDialCode');
    try {
      return super.setDialCode(dialCode);
    } finally {
      _$PhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    final _$actionInfo = _$PhoneStoreBaseActionController.startAction(
        name: 'PhoneStoreBase.setPhoneNumber');
    try {
      return super.setPhoneNumber(phoneNumber);
    } finally {
      _$PhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dialCodeList: ${dialCodeList},
dialCode: ${dialCode},
phoneNumber: ${phoneNumber},
validatedPhoneNumber: ${validatedPhoneNumber},
statusCode: ${statusCode},
isLoading: ${isLoading}
    ''';
  }
}
