library phone_store;

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:phone_validation/model/country_dial_code.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

part 'phone_store.g.dart';

class PhoneStore = PhoneStoreBase with _$PhoneStore;

abstract class PhoneStoreBase with Store {
  @observable
  ObservableList<String> dialCodeList = ObservableList();

  @observable
  String dialCode = "+852"; //default

  @observable
  String phoneNumber = "";

  @observable
  ObservableList<String> validatedPhoneNumber = ObservableList();

  @observable
  int statusCode = 0;

  @observable
  bool isLoading = false;

  @observable
  bool isExisted = false;

  @observable
  String apiKey = "";

  @action
  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('asset/code.json');
    List<CountryDialCode> countryDialCode = parseJson(jsonString);
    countryDialCode.forEach((element) {
      dialCodeList.add(element.dial_code);
    });
  }

  @action
  Future<void> loadRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("phone_numbers") != null) {
      List<String> temp = prefs.getStringList("phone_numbers");
      temp.forEach((element) {
        validatedPhoneNumber.add(element);
      });
    }
  }

  @action
  Future<void> loadApiKeys() async {
    String jsonString = await rootBundle.loadString('asset/secrets.json');
    var temp = json.decode(jsonString);
    apiKey = temp["apiToken"];
  }

  @action
  List<CountryDialCode> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<CountryDialCode>((json) => new CountryDialCode.fromJson(json))
        .toList();
  }

  @action
  void setDialCode(String dialCode) {
    this.dialCode = dialCode;
  }

  @action
  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  @action
  Future<int> validatePhoneNumber() async {
    String path = "https://lookups.twilio.com/v1/PhoneNumbers/";
    path += "(" + dialCode + ")";
    path += phoneNumber;

    isLoading = true;
    statusCode = 0;

    try {
      final response = await http.get(Uri.parse(path),
          headers: {HttpHeaders.authorizationHeader: apiKey});
      print(response.body);
      var parsedJson = json.decode(response.body);
      statusCode = parsedJson["status"];

      if (statusCode != 404) {
        saveValidatedPhoneNumber("(" + dialCode + ")", phoneNumber);
      }
      isLoading = false;
    } catch (e) {
      print(e);
      isLoading = false;
    }
    return statusCode;
  }

  @action
  Future<void> saveValidatedPhoneNumber(
      String dialCode, String phoneNumber) async {
    String phoneNumberString = dialCode + phoneNumber;
    isExisted = checkNumberExistence(phoneNumberString);

    if (!isExisted) {
      validatedPhoneNumber.add(phoneNumberString);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList("phone_numbers", validatedPhoneNumber.toList());
    }
  }

  @action
  bool checkNumberExistence(String number) {
    return validatedPhoneNumber.contains(number);
  }
}
