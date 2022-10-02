import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/bloc/save_bloc.dart';
import 'package:practica1/preview.dart';
import 'package:practica1/recording.dart';
import 'package:practica1/savedComponent.dart';

class SavedSongs extends StatefulWidget {
  const SavedSongs({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedSongs> createState() => _SavedSongsState();
}

class _SavedSongsState extends State<SavedSongs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saved Songs',
      theme: ThemeData(
        colorScheme: ColorScheme.highContrastDark(),
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Recording(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: BlocConsumer<SaveBloc, SaveState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView.builder(
                  itemCount: state.favorites.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => {
                    
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Preview(
                                song_link: state.favorites[index]['links'],
                                song_name: state.favorites[index]['song_name'],
                                cover: state.favorites[index]['cover'],
                                release_date: state.favorites[index]['release_date'],
                                album: state.favorites[index]['album'],
                                apple_music: state.favorites[index]['apple_music'],
                                spotify: state.favorites[index]['spotify'],
                                artist: state.favorites[index]['artist']))) */
                  },
                  /* child: SavedComponent(content: state.favorites[index]), */
                );
              });
            },
          )),
    );
  }
}
