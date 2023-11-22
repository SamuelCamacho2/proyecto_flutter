import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String text;
  NoDataWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/rechazado.png'),
          Text(text)
        ],
      ),
    );
  }
}