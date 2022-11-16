part of 'audio_bloc.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioState {}

class AudioListeningState extends AudioState {}

class AudioReceivedSuccessState extends AudioState {
  final String song_name;
  final String album;
  final String artist;
  final String cover;
  final String spotify;
  final String links;
  final String applemusic;
  final String release_date;

  AudioReceivedSuccessState(
      {required this.song_name,
      required this.album,
      required this.artist,
      required this.cover,
      required this.spotify,
      required this.links,
      required this.applemusic,
      required this.release_date});
}

class AudioReceivedErrorState extends AudioState {}
