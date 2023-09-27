import 'package:flutter/material.dart';
import 'package:mail_merge/providerLanguage/locale_provider.dart';
import 'package:provider/provider.dart';

List<String> items = ["  Español", "  English", "  Portuguese"];
String? selectedItem = "  Español";

class DropDownB extends StatefulWidget {
  // final VoidCallback refresh;
  const DropDownB({super.key});

  @override
  State<DropDownB> createState() => _DropDownBState();
}

class _DropDownBState extends State<DropDownB> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        // color: Colors.indigo,
      ),
      // decoration: InputDecoration(
      //     border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(12),
      //         borderSide: const BorderSide(width: 3, color: Colors.blue)),
      //     enabledBorder: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(12),
      //         borderSide: const BorderSide(width: 3, color: Colors.blue))),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 18),
                ),
              ))
          .toList(),
      value: selectedItem,
      onChanged: (item) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);

        selectedItem = item;

        switch (selectedItem) {
          case "  Español":
            provider.setLocale(const Locale('es'));
            PrefsApp.lang = "es";
            break;

          case "  English":
            provider.setLocale(const Locale('en'));
            PrefsApp.lang = "en";
            break;

          case "  Portuguese":
            provider.setLocale(const Locale('pt'));
            PrefsApp.lang = "pt";
            break;
          default:
        }
      },
    );
  }
}
