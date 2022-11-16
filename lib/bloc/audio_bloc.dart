import 'dart:convert';
import 'dart:io';
import 'package:record/record.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioState get initial => AudioInitial();

  AudioBloc() : super(AudioInitial()) {
    on<AudioEvent>(_audioShazam);
  }

  void _audioShazam(event, emit) async {
    final path = await getPath();
    final myAudioFile = await recording(path, emit);
    final audioApp = await convertFile(myAudioFile);

    /* This has all my info */
    var apiRes = await audD(audioApp);
    print(apiRes);
    /* Start sectioning */
    try {
      final String song_name = apiRes['result']['title'];
      final String album = apiRes['result']['album'];
      final String artist = apiRes['result']['artist'];
      final String cover =
          apiRes['result']['spotify']['album']['images'][0]['url'];
      final String spotify =
          apiRes['result']['spotify']['external_urls']['spotify'];
      final String links = apiRes['result']['song_link'];
      final String applemusic = apiRes['result']['apple_music']['url'];
      final String release_date = apiRes['result']['release_date'];

      emit(AudioReceivedSuccessState(
          song_name: song_name,
          album: album,
          artist: artist,
          cover: cover,
          spotify: spotify,
          links: links,
          applemusic: applemusic,
          release_date: release_date));
    } catch (e) {
      emit(AudioReceivedErrorState());
    }
  }

  Future<String?> recording(String path, Emitter<dynamic> emit) async {
    final Record audioFile = Record();

    try {
      emit(AudioListeningState());
      if (await audioFile.hasPermission()) {
        print('grabando');
        await audioFile.start(
          path: '${path}/ejemplo.mp3',
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );
        await Future.delayed(Duration(seconds: 5));
        return await audioFile.stop();
      }
    } catch (error) {
      emit(AudioReceivedErrorState());
      print('error');
    }
  }

  Future<dynamic> audD(String audio) async {
    http.Response apiResponse = await http.post(
      Uri.parse('https://api.audd.io/'),
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      body: jsonEncode(
        <String, dynamic>{
          'api_token': '25adafcd04a5b9b7e576dcb300364565',
          'return': 'spotify,apple_music',
          'audio': audio,
          'method': 'recognize',
        },
      ),
    );

    if (apiResponse.statusCode == 200) {
      return jsonDecode(apiResponse.body);
    } else {
      return null;
    }
  }

  Future<String> getPath() async {
    Directory tempDirectory = await getTemporaryDirectory();
    return tempDirectory.path;
  }

  Future<dynamic> convertFile(songFile) async {
    File file = File(songFile!);

    List<int> bfile = await file.readAsBytes();
    return base64Encode(bfile);
  }
}
