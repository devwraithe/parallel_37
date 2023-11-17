import 'package:equatable/equatable.dart';

abstract class VerifyAuthState extends Equatable {
  const VerifyAuthState();
  @override
  List<Object> get props => [];
}

class VerifyAuthInitial extends VerifyAuthState {}

class VerifyAuthLoading extends VerifyAuthState {}

class Authenticated extends VerifyAuthState {}

class Unauthenticated extends VerifyAuthState {}
