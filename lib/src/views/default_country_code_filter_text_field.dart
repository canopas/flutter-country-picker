import 'package:flutter/material.dart';

///Default view for the country code filter text field
class DefaultCountryCodeFilterTextField extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color fillColor;
  final TextStyle hintStyle;
  final TextStyle style;
  final void Function(String)? filter;

  const DefaultCountryCodeFilterTextField({
    super.key,
    this.margin =
        const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
    this.hintText = "Search Country",
    this.prefixIcon = const Icon(
      Icons.search_rounded,
      color: Colors.black87,
      size: 24,
    ),
    this.suffixIcon,
    this.fillColor = const Color(0xFFE0E0E0),
    this.filter,
    this.hintStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
    this.style = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: hintStyle,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: style,
        onChanged: filter,
      ),
    );
  }
}
