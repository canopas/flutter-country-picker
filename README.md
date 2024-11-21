A Simple, Customizable Flutter Country picker for picking a Country or Dialing code with Search functionality. 

## Preview

<img src="https://github.com/canopas/flutter-country-picker/raw/main/gif/sample.gif" width="32%" />


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
    //Note: Cannot provide both onCountryCodeTap and codeBuilder, as onCountryCodeTap will not work if you have provided codeBuilder.
)
```

<br/>

How to get a country code from the country [alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2):,
```dart
CountryCode code = CountryCode.getCountryCodeByAlpha2(
    countryAlpha2Code:"IN", // its case-insensitive you can use both IN or in
);
```      

<br/>

You can use await Alpha2CountryCode,getCurrentCountryCode() to obtain the current alpha-2 code:
```dart
String countryAlpha2Code = await Alpha2CountryCode.getCurrentCountryCode();

CountryCode code = CountryCode.getCountryCodeByAlpha2(
  countryAlpha2Code: countryAlpha2Code,
);
```
> Note: Using await Alpha2CountryCode.getCurrentCountryCode() will return the current country alpha-2 code based on the IP location from the 'http://ip-api.com/json/' API.

<br/>

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
> Note: Instead of using a dial code, which can be shared by multiple countries, we recommend using the alpha-2 code.

<br/>

How to get a country codes from the country [dial code](https://en.wikipedia.org/wiki/List_of_country_calling_codes),
```dart
List<CountryCode> code = CountryCode.getCountryCodesByDialCode(
    dialCode: "+47",
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
    // Note: onCountryCodeTap will be overridden by codeBuilder in customizationBuilders.

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
You can follow us on Twitter at [@canopas_eng](https://x.com/canopas_eng) for project updates and releases.

We regularly upload blogs on new topics, which you can read [here](https://blog.canopas.com/).

