// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_tdd_app/core/functions/failure_to_message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture_tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
  }) : super(InitialNumberTriviaState()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetConcreteNumberTriviaEvent) {
        emit(LoadingNumberTriviaState());
        final concreteNumberTrivia =
            await getConcreteNumberTrivia(event.number);
        concreteNumberTrivia.fold(
          (failure) =>
              emit(ErrorNumberTriviaState(message: failureToMessage(failure))),
          (numbertrivia) =>
              emit(LoadedNumberTriviaState(numberTrivia: numbertrivia)),
        );
      } else if (event is GetRandomNumberTriviaEvent) {
        emit(LoadingNumberTriviaState());
        final randomNumberTrivia = await getRandomNumberTrivia();
        randomNumberTrivia.fold(
          (failure) =>
              emit(ErrorNumberTriviaState(message: failureToMessage(failure))),
          (numbertrivia) =>
              emit(LoadedNumberTriviaState(numberTrivia: numbertrivia)),
        );
      }
    });
  }
}
