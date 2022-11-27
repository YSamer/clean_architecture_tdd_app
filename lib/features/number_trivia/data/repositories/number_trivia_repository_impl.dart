import 'package:clean_architecture_tdd_app/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture_tdd_app/core/error/failures.dart';
import 'package:clean_architecture_tdd_app/core/network/network_info.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await getNumberTrivia(
      () => remoteDataSource.getConcreteNumberTrivia(number),
    );
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await getNumberTrivia(
      () => remoteDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<Failure, NumberTrivia>> getNumberTrivia(
      Future<NumberTriviaModel> Function() typeGetNumberTrivia) async {
    if (await networkInfo.isNetworkConnected) {
      try {
        final NumberTriviaModel remotePosts = await typeGetNumberTrivia();
        localDataSource.cacheNumberTrivia(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getLastNumberTrivia();
        return Right(localPosts);
      } on CacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
