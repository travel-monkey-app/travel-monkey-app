import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(PhoneNumber)? onChanged;

   const CustomPhoneNumberField(
      {super.key, this.controller, this.focusNode, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      focusNode: focusNode,
      initialCountryCode: 'CY',
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusColor: Theme.of(context).primaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),

        // hintText: 'Enter phone number',
      ),
      languageCode: "en",
      onChanged: onChanged,
      onCountryChanged: (country) {},
    );
  }
}
