import 'views/default_country_code_filter_text_field.dart';
import 'views/default_country_code_list_item_view.dart';
import 'package:flutter/material.dart';
import 'models/country_code.dart';
import 'models/customization_builders.dart';

/// [CountryCodeSelector] provides a country code selection interface, allowing users
/// to choose a country code from a country code list.
/// It includes a filter country by search.
class CountryCodeSelector extends StatefulWidget {
  final String? countryNameLocale;
  final ScrollController? scrollController;
  final Color backgroundColor;
  final ShapeBorder shape;
  final void Function(CountryCode code)? onCountryCodeTap;
  final CustomizationBuilders? customizationBuilders;

  CountryCodeSelector({
    super.key,
    this.scrollController,
    this.backgroundColor = Colors.white,
    required this.onCountryCodeTap,
    this.shape = const RoundedRectangleBorder(),
    this.customizationBuilders,
    this.countryNameLocale,
  }) : assert(
            !(onCountryCodeTap != null &&
                customizationBuilders?.codeBuilder != null),
            'Cannot provide both onCountryCodeTap and codeBuilder, as onCountryCodeTap will not work if you have provided codeBuilder.');

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  void _filter(String filterText) {
    setState(() {
      if (filterText.trim().isEmpty) {
        filteredCodes = CountryCode.allCodes.toList();
      } else {
        filteredCodes = CountryCode.allCodes
            .where(
              (element) =>
                  element.name
                      .toLowerCase()
                      .startsWith(filterText.trim().toLowerCase()) ||
                  element.dialCode.startsWith(filterText.trim()) ||
                  element.dialCode.startsWith('+${filterText.trim()}'),
            )
            .toList();
      }
    });
  }

  List<CountryCode> filteredCodes = [];

  @override
  void initState() {
    filteredCodes = CountryCode.allCodes.toList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    filteredCodes.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: widget.shape,
        color: widget.customizationBuilders?.backgroundColor?.call() ??
            widget.backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
              visible: widget.customizationBuilders?.textFieldBuilder == null,
              replacement: widget.customizationBuilders?.textFieldBuilder
                      ?.call(_filter) ??
                  const SizedBox(),
              child: DefaultCountryCodeFilterTextField(
                margin: widget.customizationBuilders?.searchFieldPadding,
                filter: _filter,
              )),
          Expanded(
            child: Visibility(
              visible: widget.customizationBuilders?.countryListBuilder == null,
              replacement: widget.customizationBuilders?.countryListBuilder
                      ?.call(filteredCodes, widget.scrollController) ??
                  const SizedBox(),
              child: Scrollbar(
                interactive: true,
                controller: widget.scrollController,
                child: ListView.separated(
                  controller: widget.scrollController,
                  padding: (widget.customizationBuilders?.countryListPadding ??
                          EdgeInsets.zero) +
                      MediaQuery.of(context).padding,
                  itemCount: filteredCodes.length,
                  separatorBuilder:
                      widget.customizationBuilders?.codeSeparatorBuilder ??
                          (context, index) => const SizedBox(height: 0),
                  itemBuilder: (context, index) =>
                      widget.customizationBuilders?.codeBuilder
                          ?.call(filteredCodes[index]) ??
                      DefaultCountryCodeListItemView(
                        locale: widget.countryNameLocale,
                        code: filteredCodes[index],
                        onCountryCodeTap: () {
                          widget.onCountryCodeTap?.call(filteredCodes[index]);
                        },
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
