import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/bloc/number_trivia_bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControlWidget extends StatefulWidget {
  const TriviaControlWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControlWidget> createState() => _TriviaControlWidgetState();
}

class _TriviaControlWidgetState extends State<TriviaControlWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input a number',
                ),
                validator: (value) {
                  return value!.isEmpty
                      ? 'Can\'t be empty'
                      : RegExp(r'^\d{1,15}$').hasMatch(controller.text)
                          ? null
                          : 'Enter integer number';
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          BlocProvider.of<NumberTriviaBloc>(context)
                              .add(GetConcreteNumberTriviaEvent(
                            numberString: controller.text,
                          ));
                        }
                      },
                      color: Colors.green,
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        BlocProvider.of<NumberTriviaBloc>(context)
                            .add(GetRandomNumberTriviaEvent());
                      },
                      color: Colors.black54,
                      child: const Text(
                        'Get Random Trivia',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
