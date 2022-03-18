import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';


class StandardFormTextField extends StatelessWidget {
  final TextEditingController? controller;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fieldBorderColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final IconData? icon;

  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? tooltip;
  final Function()? onPressed;
  RegExp? regExp = new RegExp(r'^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$');
  Iterable<RegExpMatch>? matches;
  final String? Function(String?)? validate;

  final String? formTextFieldLabel;
  final bool? obsecureText;
  final int? maxLines;

  StandardFormTextField({
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.fieldBorderColor,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.icon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.tooltip,
    this.onPressed,
    this.matches,
    this.formTextFieldLabel,
    this.obsecureText,
    this.maxLines,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: null,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        labelText: formTextFieldLabel,
        labelStyle:const TextStyle(
            color: Colors.black, fontSize: 19.0, fontStyle: FontStyle.italic),
        //hintText: 'Type Your Password',
        //hintStyle: TextStyle(color: Colors.black87,fontSize: 16.0),
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        /*suffixIcon: IconButton(
          icon: Icon(Icons.text_fields),
            iconSize: 35.0,
            color: Colors.black,
            tooltip: tooltip,
            alignment: Alignment.centerRight,
            onPressed: onPressed,
          ),*/
        border:OutlineInputBorder(
          borderSide: BorderSide(
            color: fieldBorderColor!,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gapPadding: 4.0,
        ),
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        errorStyle: TextStyle(color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red, width: 1.0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        fontStyle: FontStyle.italic,
      ),
      strutStyle: StrutStyle(),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: true,
      enableSuggestions: true,
      obscureText: obsecureText!,
      maxLines: maxLines,
      validator: validate,
      /*(val)=> !val.contains(pattern) ||  val.isEmpty? 'Invalid Charachters': null,*/
      //onSaved: (val)=> _text = val ,
      toolbarOptions:
      const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      autofocus: false,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}

class FormTextFieldStandard extends StatelessWidget {
  FormTextFieldStandard(
      {Key? key,
      this.controller,
      this.textInputType,
      this.textInputAction,
      this.fontSize,
      this.fontWeight,
      this.fontColor,
      this.prefixIcons,
      this.initialText,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.tooltip,
      this.onClearTextIconPressed,
      this.validate,
      this.formTextFieldLabel,
      this.maxLines,
      this.obesecureText,
      this.closeIconSize})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final Icons? prefixIcons;
  final String? initialText;

  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? tooltip;
  final Function()? onClearTextIconPressed;
  RegExp? regExp = RegExp(r'^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$');
  Iterable<RegExpMatch>? matches;
  final String? Function(String?)? validate;

  final String? formTextFieldLabel;
  final int? maxLines;
  final bool? obesecureText;
  final double? closeIconSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialText,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        //icon:const Icon(CarbonIcons.search),
        iconColor: Colors.red,
        prefixIconColor: Colors.red,
        //label:const Icon(CarbonIcons.search),
        labelText: formTextFieldLabel,
        //labelStyle: const TextStyle(color: Colors.black, fontSize: 14.0, fontStyle: FontStyle.italic),
        //hintText: 'Type Your Password',
        //hintStyle: TextStyle(color: Colors.black87,fontSize: 16.0),
        hintMaxLines: 1,
        prefixIcon: const Icon(
          CarbonIcons.search,
          color: Colors.teal,
        ),
        suffixIcon: IconButton(
          padding: const EdgeInsets.all(1.0),
          icon: const Icon(CarbonIcons.close),
          iconSize: closeIconSize!,
          color: Colors.purple,
          // tooltip: tooltip,
          alignment: Alignment.center,
          onPressed: onClearTextIconPressed,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gapPadding: 4.0,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orangeAccent,
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.black),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        fontStyle: FontStyle.italic,
      ),
      strutStyle: const StrutStyle(),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: true,
      enableSuggestions: true,
      maxLines: maxLines,
      validator: validate,
      /*(val)=> !val.contains(pattern) ||  val.isEmpty? 'Invalid Charachters': null,*/
      //onSaved: (val)=> _text = val ,
      toolbarOptions: const ToolbarOptions(
          copy: true, cut: true, paste: true, selectAll: true),
      autofocus: false,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}

class Form_Text_Field_Text extends StatelessWidget {
  String? tf_label;
  TextEditingController? fieldController;
  IconData? icon;

  String? _text;
  Pattern? pattern =
      '^([A-HK-PRSVWY][A-HJ-PR-Y])\s?([0][2-9]|[1-9][0-9])\s?[A-HJ-PR-Z]{3}\$';
  Function()? onTap;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  Function()? onEditingComplete;
  Function()? onPressed;
  String? tooltip;

  Form_Text_Field_Text(
      {this.tf_label,
        this.fieldController,
        this.icon,
        this.tooltip,
        this.onChanged,
        this.onFieldSubmitted,
        this.onTap,
        this.onEditingComplete,
        this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 100,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: true,
      enableSuggestions: true,
      //obscureText: true,
      controller: fieldController,
      //validator: (val)=> !val.contains(pattern)  || val.isEmpty? 'Invalid Charachters': null,
      //onSaved: (val)=> _text = val ,
      decoration: InputDecoration(
        labelText: tf_label,
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontStyle: FontStyle.italic),
        //hintText: 'Type Your Password',
        //hintStyle: TextStyle(color: Colors.black87,fontSize: 16.0),
        prefixIcon: Icon(
          icon,
          color: Colors.teal,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          iconSize: 35.0,
          color: Colors.black,
          tooltip: tooltip,
          alignment: Alignment.centerRight,
          onPressed: onPressed,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gapPadding: 4.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        errorStyle: TextStyle(color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red, width: 1.0, style: BorderStyle.solid),
        ),
      ),
      validator: (stringFieldValue) =>
      stringFieldValue!.isEmpty == true ? 'Fill The Details' : null,
      toolbarOptions:
      ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
      autofocus: false,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}
