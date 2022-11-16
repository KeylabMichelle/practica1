import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica1/bloc/save_bloc.dart';
import 'package:practica1/recording.dart';
import 'package:url_launcher/url_launcher.dart';

class Preview extends StatefulWidget {
  Preview({
    Key? key,
  }) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  bool isSaved = false;

  String dialogTitle = 'Agregar a favoritos';
  String dialogTxt =
      'El elemento será agregado a tus favoritos ¿Quieres continuar?';

  @override
  Widget build(BuildContext context) {
    final audio_res = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
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
          title: Text("Here you go"),
          actions: [
            //TODO: Add state of non fav
            IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('$dialogTitle'),
                          content: Text('$dialogTxt'),
                          actions: [
                            TextButton(
                                onPressed: () => {                                
                                       BlocProvider.of<SaveBloc>(context)
                                                .add(SaveEvent(audio_res)),
                                            Navigator.pop(context, 'Aceptar'),
                                            setState(() {
                                              isSaved = !isSaved;
                                            }) 
                                    },
                                child: const Text('Aceptar')),
                            TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancelar'),
                                child: const Text('Cancelar')),
                          ],
                        )),
                icon: Icon(Icons.favorite_border_outlined))
          ],
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 340,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(audio_res['cover']))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(audio_res['song_name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Text(audio_res['album'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
            Text(audio_res['artist'], style: TextStyle(fontSize: 15)),
            Text(audio_res['release_date'], style: TextStyle(fontSize: 15)),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Text('Abrir con:', style: TextStyle(fontSize: 15)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //TODO: Add links to song on pressed
                Tooltip(
                    message: 'Ver en Spotify',
                    child: IconButton(
                      onPressed: () async {
                        final Uri _spotify = Uri.parse(audio_res['spotify']);
                        await launchUrl(_spotify);
                      },
                      icon: FaIcon(FontAwesomeIcons.spotify),
                      iconSize: 40,
                    )),
                Tooltip(
                    message: 'Ver links',
                    child: IconButton(
                      onPressed: () async {
                        final Uri _links = Uri.parse(audio_res['song_link']);
                        await launchUrl(_links);
                      },
                      icon: FaIcon(FontAwesomeIcons.podcast),
                      iconSize: 40,
                    )),
                Tooltip(
                    message: 'Ver en Apple music',
                    child: IconButton(
                      onPressed: () async {
                        final Uri _apple = Uri.parse(audio_res['apple_music']);
                        await launchUrl(_apple);
                      },
                      icon: FaIcon(FontAwesomeIcons.apple),
                      iconSize: 40,
                    )),
              ],
            )
          ],
        ));
  }
}
