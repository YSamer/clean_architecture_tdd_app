import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/bloc/number_trivia_bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:clean_architecture_tdd_app/injections.dart' as dep_inj;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep_inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dep_inj.inj<NumberTriviaBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TDD App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NumberTriviaPage(),
      ),
    );
  }
}
