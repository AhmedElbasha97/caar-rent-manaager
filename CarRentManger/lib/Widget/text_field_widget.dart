// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:carrentmanger/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';



class CustomInputField extends StatelessWidget {
  CustomInputField(
      {Key? key,
        required this.labelText,
        this.icon,
        this.onchange,
        this.controller,
        this.keyboardType,
        this.validator,
        this.isAutoValidate = true,
        this.onFieldSubmitted,
        this.onSaved,
        this.validated,
        this.obsecure = false,
        this.focusNode,
        this.textInputAction,
        required this.hasGreenBorder,
        required this.hasIntialValue,
        this.suffixText = " ",
        this.textAligning = TextAlign.right, this.iconOfTextField,required this.isPhoneNumber})
      : super(key: key);
  final String labelText;
  final icon;
  final iconOfTextField;
  var  validated;
  final onchange;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool isAutoValidate;
  final TextInputType? keyboardType;
  final bool obsecure;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool hasGreenBorder;
  final bool hasIntialValue;
  final String? suffixText;
  final TextAlign textAligning;
  final bool isPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters:isPhoneNumber? [
        FilteringTextInputFormatter.deny(
          RegExp(r'^0+'),
        ),

      ]:[

      ],

      textAlign: textAligning,
      enableSuggestions: false,
      autocorrect: false,
      style:  TextStyle(
          fontSize: 15.0,
        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,

        color: kDarkBlueColor,
      ),
      focusNode: focusNode,
      keyboardType: keyboardType,
      cursorColor: kDarkBlueColor,
      obscureText: obsecure,
      decoration: InputDecoration(

        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        helperText: "",
        fillColor: kWhiteColor,
        filled: true,
        labelText: labelText,
        labelStyle:TextStyle(
          fontSize: 15.0,
          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
          color: kDarkBlueColor,
        ),
        hintStyle:   TextStyle(
          fontSize: 15.0,
          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
          color: kDarkBlueColor,
        ),
        prefixIcon: Padding( // لف الأيقونة داخل Padding
          padding: const EdgeInsets.only(left: 15, right: 10), // تعديل الموقع
          child: iconOfTextField,
        ),
        suffixIcon: IntrinsicWidth(
          child: Align(
            alignment: Alignment.center,
            child: icon,
          ),
        ),

        suffixText: suffixText,
        suffixStyle:  TextStyle(
        fontSize: 15.0,
        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
        color: kDarkBlueColor,
      ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(50)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(50)),
        enabledBorder:   OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color:kDarkBlueColor,),
            borderRadius: BorderRadius.circular(50)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:   const BorderSide(color: kDarkBlueColor,width: 1.5),
            borderRadius: BorderRadius.circular(50)),
      ),
      onChanged: onchange,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,

      autovalidateMode: isAutoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
