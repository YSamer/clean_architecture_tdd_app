import 'package:clean_architecture_tdd_app/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
  }) : super(text: text, number: number);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'text': text,
      'number': number,
    };
  }

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: json['number'],
    );
  }
}
