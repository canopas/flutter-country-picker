Customizable Flutter library for easy integration of a feature-rich country code picker with built-in filtering options for code selection based on search.

## Preview

<img src="https://github.com/canopas/flutter-country-picker/blob/main/gif/sample.gif" width="32%" />


## How to use

If you want to show the country picker bottom sheet, use:
```dart
CountryCode? code = await showCountryCodePickerSheet(context: context);
```

<br/>

If you want to show the country picker dialog, use:
```dart
CountryCode? code = await showCountryCodePickerDialog(context: context);
```

<br/>

If you want to show the country list as a UI component, use the CountryCodeSelector widget:
```dart
CountryCodeSelector(
   onCountryCodeTap: (CountryCode code) {
      /// Specify country code tap event
   },
)
```

<br/>

How to get a country code from the country [alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2):,
```dart
CountryCode code = CountryCode.getCountryCodeByAlpha2(
    countryAlpha2Code:"IN", // its case-insensitive you can use both IN or in
);
```      
You can also get the current country alpha-2 code based on the user's device region, using PlatformDispatcher [locale](https://api.flutter.dev/flutter/dart-ui/PlatformDispatcher/locale.html).
```dart
CountryCode code = CountryCode.getCountryCodeByAlpha2(
    countryAlpha2Code: WidgetsBinding.instance.platformDispatcher.locale.countryCode, 
    /// if you have context, use View.of(context).platformDispatcher.locale.countryCode
);
```
> Note: WidgetsBinding and View.of(context) are provided by the Flutter SDK.

<br/>

How to get a country code from the country [dial code](https://en.wikipedia.org/wiki/List_of_country_calling_codes),
```dart
CountryCode code = CountryCode.getCountryCodeByDialCode(
    dialCode: "+91",
);
```

<br/>

If you want to show the localized country name, use:
```dart
String? l10nCountryName = countryCode.localizedName("en");
```

<br/>


### Customizations
For customizations, we are providing the CustomizationBuilders class to customize each section.
```dart
customizationBuilders: CustomizationBuilders(
  codeBuilder: (CountryCode code) {
    // Return something to change the country list item UI.

   // If want to do some customization in default country code view, you can use
    return DefaultCountryCodeListItemView(
      onCountryCodeTap: () {},
      code: code,
      locale: 'US', // To show a localized country name,
    );
  },
  
  codeSeparatorBuilder: (BuildContext context, int index) {
    // Return something to add a separator between country codes.
    return const SizedBox(); // Default
  },
  
  countryListBuilder: (List<CountryCode> codes, ScrollController? controller) {
    // Return something to customize the country list
  },
  
  textFieldBuilder: (void Function(String)? filter) {
    // Return the search text field widget
    //
    // If you want to do some customization in the default text field, you can use
    return DefaultCountryCodeFilterTextField(
      filter: filter,
    );

    // Use filter(searchText); to update the country code list.
  },
),
```


<br/>

## Bugs and Feedback
For bugs, feedback, questions and discussions please use the [Github Issues](https://github.com/canopas/flutter-country-picker/issues).

## Credits
Canopas Country Picker is owned and maintained by the [Canopas team](https://canopas.com/).
You can follow us on Twitter at [@canopassoftware](https://twitter.com/canopassoftware) for project updates and releases.

We regularly upload blogs on new topics, which you can read [here](https://blog.canopas.com/).

## Licence
```
Copyright 2023 Canopas Software LLP

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
