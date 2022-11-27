import 'package:clean_architecture_tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/bloc/number_trivia_bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/widgets/message_widget.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/widgets/trivia_controller_widget.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/widgets/trivia_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Trivia'), centerTitle: true),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is InitialNumberTriviaState) {
                    return const MessageWidget(message: 'Start Searching!');
                  } else if (state is ErrorNumberTriviaState) {
                    return MessageWidget(message: state.message);
                  } else if (state is LoadingNumberTriviaState) {
                    return const LoadingWidget();
                  } else if (state is LoadedNumberTriviaState) {
                    return TriviaWidget(numberTrivia: state.numberTrivia);
                  }
                  return const TriviaWidget(
                    numberTrivia: NumberTrivia(number: 5, text: 'Starting..'),
                  );
                },
              ),
              const SizedBox(height: 20),
              const TriviaControlWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
