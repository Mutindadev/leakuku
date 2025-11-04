import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failure {
  final String message;
  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class DataNotFoundFailure extends Failure {}

class CacheFailure extends Failure {}
