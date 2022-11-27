import 'package:clean_architecture_tdd_app/core/error/failures.dart';
import 'package:clean_architecture_tdd_app/core/string/failures.dart';

String failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return unexpectedFailureMessage;
    }
  }