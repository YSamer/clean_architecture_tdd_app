import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
