import 'dart:convert';
import 'dart:io';

class Alpha2CountryCode {

  /// Retrieves a [CountryCode] from ip address.
  static Future<String> getCurrentCountryCode() async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse("http://ip-api.com/json/"));
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final jsonMap = json.decode(responseBody);
        final countryCode = jsonMap['countryCode'];
        return countryCode;
      } else {
        throw Alpha2CountryCodeException(
          "Unable to get country code.",
          response.statusCode,
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}

class Alpha2CountryCodeException implements Exception {
  final String message;
  final int statusCode;

  const Alpha2CountryCodeException(this.message, this.statusCode);

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Alpha2CountryCodeException &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            statusCode == other.statusCode;
  }
}
