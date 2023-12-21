import 'package:flutter/material.dart'
    show BuildContext, Color, EdgeInsets, ScrollController, Widget;
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
  final Widget Function(List<CountryCode> codes, ScrollController? controller)?
      countryListBuilder;

  ///Used for separate country list items.
  final Widget Function(BuildContext context, int index)? codeSeparatorBuilder;

  ///Country code list padding
  ///
  /// Default: zero
  final EdgeInsets countryListPadding;

  ///Search country ext field padding
  ///
  /// Default: top: 16, left: 16, bottom: 8, right: 16
  final EdgeInsets searchFieldPadding;

  ///It will override backgroundColor provided by widget.
  final Color Function()? backgroundColor;

  const CustomizationBuilders({
    this.codeBuilder,
    this.codeSeparatorBuilder,
    this.textFieldBuilder,
    this.countryListBuilder,
    this.countryListPadding = const EdgeInsets.all(0),
    this.searchFieldPadding =
        const EdgeInsets.only(top: 16, left: 16, bottom: 8, right: 16),
    this.backgroundColor,
  });
}
