import 'package:flutter/material.dart';

Widget buildTextFormField({
  TextInputType? keyboardType,
  String? hintText,
  int? num,
  TextEditingController? controller,
  bool obscureText = false,
  String? Function(String)? onChanged,
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? Function(String? value)? validate,
  String? errorText,
}) {
  return SizedBox(
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        controller: controller,
        minLines: num,
        maxLines: null,
        showCursor: true,
        //keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: const EdgeInsets.all(12),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(width: 1, color: Colors.grey)),
        ),
      ),
    ),
  );
}
