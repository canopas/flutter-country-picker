import 'package:flutter/cupertino.dart'
    show BuildContext, ScrollController, Widget;
import 'country_code.dart';

/// A set of builders for customizing the appearance and behavior of a country code selection view.
class CustomizationBuilders {
  ///Default [DefaultCountryCodeListItemView]
  ///
  ///Note:It is overridden by [countryListBuilder] if [countryListBuilder] is not null.
  final Widget Function(CountryCode code)? codeBuilder;

  ///Customize the text field as desired.
  ///
  ///Note: Do not forget to call [_filter] to update the list of country codes.
  final Widget Function(void Function(String filterText)? filter)?
      textFieldBuilder;

  /// If you want to use the default country code view, use [DefaultCountryCodeListItemView].
  ///
  /// Note: It overrides the code builder.
  final Widget Function(List<CountryCode> codes, ScrollController controller)?
      countryListBuilder;

  ///Used for separate country list items.
  final Widget Function(BuildContext context, int index)? codeSeparatorBuilder;

  const CustomizationBuilders({
    this.codeBuilder,
    this.codeSeparatorBuilder,
    this.textFieldBuilder,
    this.countryListBuilder,
  });
}
