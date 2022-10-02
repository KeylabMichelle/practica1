import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:collection';

part 'save_event.dart';
part 'save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  SaveBloc() : super(SaveInitial()) {
    on<SaveEvent>(addSong);
  }

  Future<dynamic> addSong(event, emit) async {
    List list = state.favorites;

    if (!isSaved(event, emit)) {
      print('event ${event.saved[0]}');
      print('Not saved');

      list.add({
        'song_name' : event.saved[0],
        'album' :  event.saved[1],
        'cover' :  event.saved[2],
        'artist' :  event.saved[3],
        'release_date' :  event.saved[4],
        'apple_music' :  event.saved[5],
        'links' :  event.saved[6],
        'spotify' :  event.saved[7],
      });emit(SavingSong(favorites: list));

      print(list);
    } else {
      popSong(event, emit);
      print('popped: $list');
    }
  }

  Future popSong(event, emit) async {
    List list = state.favorites;
    if (isSaved(event, emit)) {
      list.removeWhere((e) =>
          e['song_name'] == event.saved[0] &&
          e['album'] == event.saved[1] &&
          e['cover'] == event.saved[2] &&
          e['artist'] == event.saved[3] &&
          e['release_date'] == event.saved[4] &&
          e['apple_music'] == event.saved[5] &&
          e['links'] == event.saved[6] &&
          e['spotify'] == event.saved[7]);
      emit(DeletingSong(favorites: list));
    }
  }

  bool isSaved(event, emit) {
    List list = state.favorites;

    bool isInFavorites = list.any((e) =>
        e['song_name'] == event.saved[0] &&
        e['album'] == event.saved[1] &&
        e['cover'] == event.saved[2] &&
        e['artist'] == event.saved[3] &&
        e['release_date'] == event.saved[4] &&
        e['apple_music'] == event.saved[5] &&
        e['links'] == event.saved[6] &&
        e['spotify'] == event.saved[7]);
    return isInFavorites;
  }
}
