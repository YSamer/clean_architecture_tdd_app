import 'dart:convert';
import 'package:clean_architecture_tdd_app/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const String baseUrl = 'http://numbersapi.com';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return await getNumberTrivia('$baseUrl/$number?json');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return await getNumberTrivia('$baseUrl/random/trivia?json');
  }

  Future<NumberTriviaModel> getNumberTrivia(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final NumberTriviaModel numberTrivia =
          NumberTriviaModel.fromJson(json.decode(response.body));
      return numberTrivia;
    } else {
      throw ServerException();
    }
  }
}
