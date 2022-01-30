import 'package:carapp/constants/LanguageConstants.dart';
import 'package:carapp/constants/Languages.dart';
import 'package:carapp/extensions/string_extensions.dart';
import 'package:carapp/services/DataService.dart';
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
            title: Text(LanguageConstants.colorPickerHeader.t(context),
                style: TextStyle(
                    fontSize: fontProvider.fontSize,
                    color: fontProvider.fontColor)),
            content: SingleChildScrollView(
              child:
                  /*ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),  */
                  BlockPicker(
                pickerColor: fontProvider.fontColor,
                onColorChanged: changeColor,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: DataService.primaryColor),
                child: Text(
                  LanguageConstants.colorPickerSelect.t(context),
                  style: TextStyle(
                      fontSize: fontProvider.fontSize, color: Colors.white),
                ),
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
            const Padding(padding: EdgeInsets.only(top: 60)),
            SizedBox(
              width: 270,
              child: Center(
                child: Row(
                  children: [
                    Text(LanguageConstants.languageTitle.t(context),
                        style: TextStyle(
                            fontSize: provider.fontSize,
                            color: provider.fontColor)),
                    const Spacer(),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          LanguageConstants.languageTitle.t(context),
                          style: TextStyle(
                              fontSize: provider.fontSize,
                              color: provider.fontColor),
                        ),
                        items: languages
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: provider.fontSize,
                                        color: provider.fontColor),
                                  ),
                                ))
                            .toList(),
                        value: selectValue,
                        onChanged: (value) {
                          setState(() {
                            selectValue = value as String;
                            final provider = Provider.of<TextService>(context,
                                listen: false);
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
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 270,
              child: Center(
                child: Row(
                  children: [
                    Text(LanguageConstants.colorTitle.t(context),
                        style: TextStyle(
                            fontSize: provider.fontSize,
                            color: provider.fontColor)),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: DataService.primaryColor),
                      onPressed: () {
                        _showDialog();
                      },
                      child: Text(LanguageConstants.colorPickTitle.t(context),
                          style: TextStyle(
                              fontSize: provider.fontSize,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Text(LanguageConstants.fontSizeTitle.t(context),
                        style: TextStyle(
                            fontSize: provider.fontSize,
                            color: provider.fontColor)),
                    Slider(
                      activeColor: DataService.primaryColor,
                      value: provider.fontSize,
                      max: 21,
                      min: 10,
                      divisions: 11,
                      label: provider.fontSize.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          provider.setFontSize(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              textColor: Colors.white,
              color: DataService.primaryColor,
              onPressed: () => { provider.setDefaults() },
              child: Text(
                LanguageConstants.setDefaults.t(context),
                style: TextStyle(
                    fontSize: provider.fontSize, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
