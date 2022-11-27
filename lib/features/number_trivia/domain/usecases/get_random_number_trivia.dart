// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_tdd_app/core/error/failures.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;
  GetRandomNumberTrivia({
    required this.numberTriviaRepository,
  });

  Future<Either<Failure, NumberTrivia>> call() async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}
