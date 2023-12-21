import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: CountryPickerDemo()));
}

TextStyle kTextStyle =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

class CountryPickerDemo extends StatefulWidget {
  const CountryPickerDemo({super.key});

  @override
  State<CountryPickerDemo> createState() => _CountryPickerDemoState();
}

class _CountryPickerDemoState extends State<CountryPickerDemo> {
  CountryCode? countryCode;
  bool selected = false;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100,left: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          counter: countryCode != null
                              ? Text(countryCode!.name)
                              : null,
                          label: const Text("Select country"),
                          labelStyle: kTextStyle,
                          suffixIcon: !selected
                              ? const Icon(Icons.arrow_drop_down_rounded)
                              : const Icon(Icons.arrow_drop_up_rounded),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.purple)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                        onTap: () async {
                          setState(() {
                            selected = !selected;
                          });
                          final code = await showPickerSheet(context);
                          setState(() {
                            if (code != null) {
                              textEditingController.text =
                                  "${code.dialCode}   ${code.name}";
                            }
                            selected = !selected;
                          });
                        },
                      ),
                    ),
                    PopupMenuButton<int>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (int value) async {
                          CountryCode? code;
                          switch (value) {
                            case 1:
                              code = await showCountryCodePickerSheet(
                                  context: context);
                              break;
                            case 2:
                              code = await showCountryCodePickerDialog(
                                  context: context);
                              break;
                            case 3:
                              code = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ShowCountryPickerPage()));
                          }
                          if (code != null) {
                            setState(() {
                              textEditingController.text =
                                  "${code!.dialCode}   ${code.name}";
                            });
                          }
                        },
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text("Show PickerSheet"),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text("Show PickerDialogue"),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: Text("Show PickerPage"),
                              ),
                            ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<CountryCode?> showPickerSheet(BuildContext context) async {
    return await showCountryCodePickerSheet(
      context: context,

      customizationBuilders: CustomizationBuilders(
          backgroundColor: () => Colors.teal.shade100,
          codeBuilder: (CountryCode code) {
            return DefaultCountryCodeListItemView(
              code: code,
              nameStyle: kTextStyle,
              onCountryCodeTap: () {
                setState(() {
                  textEditingController.text =
                  "${code.dialCode}   ${code.name}";
                });
                Navigator.pop(context);
              },
            );
          },
          codeSeparatorBuilder: (context, value) => const Divider(),
          textFieldBuilder: (value) {
            return DefaultCountryCodeFilterTextField(
                hintText: "Search", fillColor: Colors.blueGrey.shade300);
          }),
    );
  }
}

class ShowCountryPickerPage extends StatelessWidget {
  const ShowCountryPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CountryCodeSelector(
            onCountryCodeTap: (CountryCode countryCode) =>
                Navigator.pop(context, countryCode)),
      ),
    );
  }
}
