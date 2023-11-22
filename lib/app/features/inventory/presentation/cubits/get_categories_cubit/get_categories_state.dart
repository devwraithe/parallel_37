import 'package:equatable/equatable.dart';

abstract class GetCategoriesState extends Equatable {
  const GetCategoriesState();
  @override
  List<Object> get props => [];
}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesLoading extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<String> result;
  const GetCategoriesSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class GetCategoriesError extends GetCategoriesState {
  final String message;
  const GetCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
