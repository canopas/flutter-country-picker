import 'package:country_code_picker/src/views/default_country_code_filter_text_field.dart';
import 'package:country_code_picker/src/views/default_country_code_list_item_view.dart';
import 'package:flutter/material.dart';
import 'models/country_code.dart';
import 'models/customization_builders.dart';

/// [CountryCodeSelector] provides a country code selection interface, allowing users
/// to choose a country code from a country code list.
/// It includes a filter country by search.
class CountryCodeSelector extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(CountryCode code)? onCountryCodeTap;
  final EdgeInsets countryListPadding;
  final EdgeInsets filterFieldPadding;
  final CustomizationBuilders? customizationBuilders;

  const CountryCodeSelector({
    super.key,
    this.countryListPadding = const EdgeInsets.all(0),
    this.filterFieldPadding =
        const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
    required this.scrollController,
    required this.onCountryCodeTap,
    this.customizationBuilders,
  });

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
                  element.dialCode.startsWith(filterText.trim()),
            )
            .toList();
      }
    });
  }

  List<CountryCode> filteredCodes = [];

  @override
  void initState() {
    filteredCodes = CountryCode.allCodes;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    filteredCodes.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
            visible: widget.customizationBuilders?.textFieldBuilder == null,
            replacement:
                widget.customizationBuilders?.textFieldBuilder?.call(_filter) ??
                    const SizedBox(),
            child: DefaultCountryCodeFilterTextField(
              margin: widget.filterFieldPadding,
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
                padding:
                    widget.countryListPadding + MediaQuery.of(context).padding,
                itemCount: filteredCodes.length,
                separatorBuilder:
                    widget.customizationBuilders?.codeSeparatorBuilder ??
                        (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) =>
                    widget.customizationBuilders?.codeBuilder
                        ?.call(filteredCodes[index]) ??
                    DefaultCountryCodeListItemView(
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
    );
  }
}
