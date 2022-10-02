part of 'audio_bloc.dart';


abstract class AudioEvent extends Equatable {

  const AudioEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RecordAudio extends AudioEvent {}
