import 'package:equatable/equatable.dart';

abstract class AddItemState extends Equatable {
  const AddItemState();
  @override
  List<Object> get props => [];
}

class AddItemInitial extends AddItemState {}

class AddItemLoading extends AddItemState {}

class AddItemSuccess extends AddItemState {}

class AddItemError extends AddItemState {
  final String message;
  const AddItemError(this.message);

  @override
  List<Object> get props => [message];
}
