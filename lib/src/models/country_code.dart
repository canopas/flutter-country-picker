import '../constants/country_codes.dart';

class CountryCode {
  final String name;
  final Map<String, String> nameTranslations;
  final String flag;
  final String code;
  final String dialCode;
  final int minLength;
  final int maxLength;

  const CountryCode({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.nameTranslations,
    required this.minLength,
    required this.maxLength,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryCode &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          nameTranslations == other.nameTranslations &&
          flag == other.flag &&
          code == other.code &&
          dialCode == other.dialCode &&
          minLength == other.minLength &&
          maxLength == other.maxLength;

  /// Retrieves a [CountryCode] object by its two-letter alpha-2 country code.
  /// alpha-2 Examples: US, IN, its case-insensitive
  /// its return US Code if code not found
  factory CountryCode.getCountryCodeByAlpha2(
      {required String? countryAlpha2Code}) {
    return CountryCodesConst.allCountryCodes
            .where(
              (countryCode) =>
                  countryCode.code.toUpperCase() ==
                  countryAlpha2Code?.toUpperCase(),
            )
            .firstOrNull ??
        CountryCodesConst.allCountryCodes
            .where((countryCode) => countryCode.code.toUpperCase() == "US")
            .first;
  }

  /// Retrieves a [CountryCode] object by its dial code.
  /// Dial Code Examples: +1, +91
  /// its return US Code if code not found
  factory CountryCode.getCountryCodeByDialCode({required String? dialCode}) {
    return CountryCodesConst.allCountryCodes
            .where(
              (countryCode) => countryCode.dialCode == dialCode,
            )
            .firstOrNull ??
        CountryCodesConst.allCountryCodes
            .where((countryCode) => countryCode.dialCode == "+1")
            .first;
  }

  static List<CountryCode> get allCodes => CountryCodesConst.allCountryCodes;

  String get dialCodeWithoutPlusPrefix => dialCode.toString().substring(1);

  ///Retrieves a localized country name.
  String localizedName(String languageCode) {
    return nameTranslations[languageCode] ?? name;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      flag.hashCode ^
      code.hashCode ^
      dialCode.hashCode ^
      nameTranslations.hashCode ^
      minLength.hashCode ^
      maxLength.hashCode;
}
