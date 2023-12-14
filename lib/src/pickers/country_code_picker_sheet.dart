import 'package:flutter/material.dart';
import '../country_code_selector.dart';
import '../models/country_code.dart';
import '../models/customization_builders.dart';

Future<CountryCode?> showCountryCodePickerSheet({
  required BuildContext context,
  void Function(CountryCode code)? onCountryCodeTap,
  CustomizationBuilders? customizationBuilders,
  Color backgroundColor = Colors.white,
  double maxSize = 1,
  double initialSize = 0.5,
  double minSize = 0.5,
  bool snap = true,
  ShapeBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(24),
    ),
  ),
  String? countryNameLocale,
}) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: backgroundColor,
    shape: shape,
    context: context,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      maxChildSize: maxSize,
      initialChildSize: initialSize,
      minChildSize: minSize,
      snap: snap,
      builder: (context, scrollController) {
        return CountryCodeSelector(
          countryNameLocale: countryNameLocale,
          scrollController: scrollController,
          customizationBuilders: customizationBuilders,
          onCountryCodeTap: onCountryCodeTap ??
              (CountryCode code) {
                Navigator.pop(context, code);
              },
        );
      },
    ),
  );
}
