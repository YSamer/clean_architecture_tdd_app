import 'dart:convert';
import 'package:clean_architecture_tdd_app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<Unit> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

const String cachedKey = 'NumberTrivia';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) {
    sharedPreferences.setString(
      cachedKey,
      json.encode(numberTriviaModel.toJson()),
    );
    return Future.value(unit);
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedKey);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
