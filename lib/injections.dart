import 'package:clean_architecture_tdd_app/core/network/network_info.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/presentation/bloc/number_trivia_bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final inj = GetIt.instance;

Future<void> init() async {
  // BLoC
  inj.registerFactory(() => NumberTriviaBloc(
        getConcreteNumberTrivia: inj(),
        getRandomNumberTrivia: inj(),
      ));

  // User Cases
  inj.registerLazySingleton(() => GetConcreteNumberTrivia(numberTriviaRepository: inj()));
  inj.registerLazySingleton(() => GetRandomNumberTrivia(numberTriviaRepository: inj()));

  // Repo
  inj.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
      remoteDataSource: inj(), localDataSource: inj(), networkInfo: inj()));
  // Data Sources
  inj.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: inj()));
  inj.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: inj()));

  // Core
  inj.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: inj()));
  // Base
  final sharedPreferences = await SharedPreferences.getInstance();
  inj.registerLazySingleton(() => sharedPreferences);
  inj.registerLazySingleton(() => http.Client());
  inj.registerLazySingleton(() => InternetConnectionChecker());
}
