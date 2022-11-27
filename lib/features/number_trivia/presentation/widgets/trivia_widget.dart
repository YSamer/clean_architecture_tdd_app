import 'package:clean_architecture_tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaWidget extends StatelessWidget {
  const TriviaWidget({
    Key? key,
    required this.numberTrivia,
  }) : super(key: key);

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            numberTrivia.number.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
