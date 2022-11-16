import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/bloc/save_bloc.dart';
import 'package:practica1/preview.dart';
import 'package:practica1/recording.dart';

class SavedSongs extends StatefulWidget {
  const SavedSongs({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedSongs> createState() => _SavedSongsState();
}

class _SavedSongsState extends State<SavedSongs> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SaveBloc>(context, listen: false)
        .pullFavorites()
        .then((value) => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
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
        ),
        body: BlocConsumer<SaveBloc, SaveState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.builder(
                itemCount: BlocProvider.of<SaveBloc>(context).lista.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Preview(),
                                settings: RouteSettings(
                                  arguments: BlocProvider.of<SaveBloc>(context,
                                          listen: false)
                                      .lista[index],
                                ),
                              ),
                            ),
                          },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    child: Card(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fitWidth,
                                                      image: NetworkImage(
                                                          '${BlocProvider.of<SaveBloc>(context, listen: false).lista[index]['cover']}'))),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${BlocProvider.of<SaveBloc>(context, listen: false).lista[index]['song_name']}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '${BlocProvider.of<SaveBloc>(context, listen: false).lista[index]['artist']}',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () =>
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  'Eliminar de favoritos'),
                                                              content: Text(
                                                                  'Seguro que quieres eliminar esta canción de tus favoritos?'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        {
                                                                          BlocProvider.of<SaveBloc>(context).add(SaveEvent(BlocProvider.of<SaveBloc>(context, listen: false).lista[index])),
                                                                          Navigator.pop(context, 'Aceptar'),
                                                                          setState(() {})
                                                                        },
                                                                    child:
                                                                        const Text('Aceptar')),
                                                                TextButton(
                                                                    onPressed: () => Navigator.pop(
                                                                        context,
                                                                        'Cancelar'),
                                                                    child:
                                                                        const Text('Cancelar')),
                                                              ],
                                                            )),
                                                iconSize: 20.0,
                                                icon: Icon(Icons.favorite))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          )));
                });
          },
        ));
  }
}
