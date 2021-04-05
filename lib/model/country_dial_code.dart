class CountryDialCode {
  final String name;
  final String dial_code;
  final String code;

  CountryDialCode({this.name, this.dial_code, this.code});

  factory CountryDialCode.fromJson(Map<String, dynamic> json) {
    return new CountryDialCode(
      name: json['name'] as String,
      dial_code: json['dial_code'] as String,
      code: json['code'] as String,
    );
  }
}
