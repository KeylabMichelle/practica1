import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/bloc/audio_bloc.dart';
import 'package:practica1/preview.dart';
import 'package:practica1/saved_songs.dart';

class Recording extends StatefulWidget {
  const Recording({
    Key? key,
  }) : super(key: key);

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
    String song_link = '';
    String song_name = '';
    String cover = '';
    String release_date = '';
    String album = '';
    String spotify = '';
    String apple_music = '';
    String artist = '';
    String text = 'Toque para escuchar';
    bool glow_toggle = false;
  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      title: 'Recording page',
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastDark(),
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          body: Container(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AudioBloc, AudioState>(
          listener: (context, state) {
            if(state is AudioListeningState){
              glow_toggle = true;
              text = 'Escuchando . . .';
            }
            else if (state is AudioReceivedSuccessState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Preview(
                  song_link: state.links,
                  song_name: state.song_name,
                  cover: state.cover,
                  release_date: state.release_date,
                  album: state.album,
                  apple_music: state.applemusic,
                  spotify: state.spotify,
                  artist: state.artist,
                ),
              ));
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: const EdgeInsets.all(40.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                AvatarGlow(
                  animate: glow_toggle,
                  endRadius: 190.0,
                  glowColor: Colors.purple,
                  repeat: true,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(30),
                      icon: Image.asset(
                        'assets/musical-note.png',
                      ) ,                     
                      color: Colors.white,
                      iconSize: 150,
                      onPressed: () {BlocProvider.of<AudioBloc>(context).add(RecordAudio());},
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: Tooltip(
                      message: 'Ver favoritos',
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SavedSongs(),
                            ),
                          );
                        },
                        icon: Icon(Icons.favorite),
                        color: Colors.black,
                        iconSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
