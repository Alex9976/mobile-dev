import 'package:carapp/constants/Languages.dart';
import 'package:carapp/services/TextService.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> languages = Languages.languages.map((e) => e.value).toList();
  String selectValue =
      Languages.languageValue[TextService().locale.languageCode].toString();

  Color pickerColor = Colors.black;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          final fontProvider = Provider.of<TextService>(context);

          return AlertDialog(
            title: Text('Pick a color!'),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: fontProvider.fontColor,
                onColorChanged: changeColor,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  fontProvider.setFontColor(pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TextService>(context);
    final locale = provider.locale;
    selectValue = Languages.languageValue[locale.languageCode].toString();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 40)),
            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: languages
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectValue,
                  onChanged: (value) {
                    setState(() {
                      selectValue = value as String;
                      final provider =
                          Provider.of<TextService>(context, listen: false);
                      final locale =
                          Locale(Languages.languageCode[value] ?? 'en');
                      provider.setLocale(locale);
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 140,
                  itemHeight: 40,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showDialog();
              },
              child: Text('Show Simple Dialog',
                  style: TextStyle(
                  fontSize: provider.fontSize, color: provider.fontColor)),
            ),
            Slider(
              value: provider.fontSize,
              max: 21,
              min: 10,
              divisions: 10,
              label: provider.fontSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  provider.setFontSize(value);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
