import 'package:flutter/material.dart';
import 'package:country_code_picker/src/models/country_code.dart';
import 'package:country_code_picker/src/models/customization_builders.dart';
import 'package:country_code_picker/src/country_code_selector.dart';

Future<CountryCode?> showCountryCodePickerSheet({
  required BuildContext context,
  void Function(CountryCode code)? onCountryCodeTap,
  EdgeInsets countryListPadding =
      const EdgeInsets.only(top: 8, left: 16, bottom: 16, right: 16),
  EdgeInsets filterTextFieldPadding =
      const EdgeInsets.only(top: 16, left: 16, bottom: 8, right: 16),
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
          countryListPadding: countryListPadding,
          filterFieldPadding: filterTextFieldPadding,
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
