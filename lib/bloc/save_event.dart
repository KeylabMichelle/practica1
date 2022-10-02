part of 'save_bloc.dart';

abstract class SaveEvent extends Equatable {
  const SaveEvent();

  @override
  List<Object> get props => [];
}


class saveSong extends SaveEvent {
  List<dynamic> saved;
  saveSong(this.saved);
}

