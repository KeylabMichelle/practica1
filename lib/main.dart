import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/preview.dart';
import 'package:practica1/recording.dart';
import 'package:practica1/saved_songs.dart';
import 'bloc/audio_bloc.dart';
import 'bloc/save_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AudioBloc(),
      ),
      BlocProvider(create: (context) => SaveBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastDark(),
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      initialRoute: "/recording",
      routes: {
        "/recording": (context) => Recording(),
        "/preview": (context) => Preview(
            song_link: '',
            song_name: '',
            cover: '',
            release_date: '',
            album: '',
            apple_music: '',
            spotify: '',
            artist: ''),
        "/saved_songs": (context) => SavedSongs()
      },
    );
  }
}
