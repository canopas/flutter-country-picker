import 'package:flutter/material.dart';
import '../country_code_selector.dart';
import '../models/country_code.dart';
import '../models/customization_builders.dart';

Future<CountryCode?> showCountryCodePickerDialog({
  required BuildContext context,
  void Function(CountryCode code)? onCountryCodeTap,
  EdgeInsets countryListPadding = const EdgeInsets.all(0),
  EdgeInsets filterTextFieldPadding =
      const EdgeInsets.only(top: 16, left: 16, bottom: 8, right: 16),
  EdgeInsets margin =
      const EdgeInsets.symmetric(horizontal: 028, vertical: 100),
  CustomizationBuilders? customizationBuilders,
  Color color = Colors.white,
  BorderSide borderSide = BorderSide.none,
  double elevation = 0.0,
  Color? shadowColor,
  Color? surfaceTintColor,
  Color barrierColor = Colors.black54,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  BorderRadiusGeometry? borderRadius,
  double maxSize = 1,
  double initialSize = 0.5,
  double minSize = 0.5,
  bool snap = true,
}) async {
  return await showDialog(
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    context: context,
    builder: (context) => Padding(
      padding: margin,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(24),
          side: borderSide,
        ),
        elevation: elevation,
        surfaceTintColor: surfaceTintColor,
        shadowColor: shadowColor,
        color: color,
        child: SafeArea(
          child: CountryCodeSelector(
            countryListPadding: countryListPadding,
            filterFieldPadding: filterTextFieldPadding,
            customizationBuilders: customizationBuilders,
            onCountryCodeTap: onCountryCodeTap ??
                (CountryCode code) {
                  Navigator.pop(context, code);
                },
          ),
        ),
      ),
    ),
  );
}
