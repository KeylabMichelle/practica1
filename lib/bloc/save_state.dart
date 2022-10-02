// ignore_for_file: must_be_immutable

part of 'save_bloc.dart';


abstract class SaveState extends Equatable {
  SaveState();

  
  List<dynamic> favorites = [];

  @override
  List<Object> get props => [];
  
}

class SaveInitial extends SaveState {}


class SavingSong extends SaveState {
  
    SavingSong({required favorites});

}

class DeletingSong extends SaveState {

    DeletingSong({required favorites});
}

class FindingSong extends SaveState {}

class SavingError extends SaveState {
  final String error;

  SavingError({required this.error});

  @override
  List<Object> get props => [error];
}