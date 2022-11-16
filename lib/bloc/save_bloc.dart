import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';

part 'save_event.dart';
part 'save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  List lista = [];
  SaveBloc() : super(SaveInitial()) {
    on<SaveEvent>(addSong);
  }

  Future<dynamic> addSong(event, emit) async {
    Map list = event.saved;

    print(list);

    if (!isSaved(event, emit)) {
      print('event ${event.saved[0]}');
      print('Not saved');

      lista.add(list);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'favorites': lista});
      emit(SavingSong(favorites: list));

      print('Canción agregada, lista actualizada: $lista');
    } else {
      popSong(event, emit);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'favorites': lista});
      emit(DeletingSong(favorites: list));
      print('Lista after pop: $lista');
    }
  }

  Future popSong(event, emit) async {
    if (isSaved(event, emit)) {
      lista.removeWhere((e) =>
          e['song_name'] == event.saved['song_name'] &&
          e['album'] == event.saved['album'] &&
          e['cover'] == event.saved['cover'] &&
          e['artist'] == event.saved['artist'] &&
          e['release_date'] == event.saved['release_date'] &&
          e['apple_music'] == event.saved['apple_music'] &&
          e['links'] == event.saved['links'] &&
          e['spotify'] == event.saved['spotify']);
      emit(DeletingSong(favorites: lista));
    }
  }

  bool isSaved(event, emit) {
    bool isInFavorites = lista.any((e) =>
        e['song_name'] == event.saved['song_name'] &&
        e['album'] == event.saved['album'] &&
        e['cover'] == event.saved['cover'] &&
        e['artist'] == event.saved['artist'] &&
        e['release_date'] == event.saved['release_date'] &&
        e['apple_music'] == event.saved['apple_music'] &&
        e['links'] == event.saved['links'] &&
        e['spotify'] == event.saved['spotify']);

    print(isInFavorites);
    return isInFavorites;
  }

  Future<void> pullFavorites() async {
    final user = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final favorites = await user.get();
    if (favorites.exists && favorites.data()!['favorites'] != null) {
      lista = favorites.data()!['favorites'];
    } else {
      lista = [];
    }
  }
}
