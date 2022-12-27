import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBottun extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback clickCallback;
  TextBottun(
      {Key? key,
      required this.text,
      required this.clickCallback,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => clickCallback(),
      child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          )),
    );
  }
}
