import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/preview.dart';
import 'package:practica1/recording.dart';
import 'package:practica1/saved_songs.dart';
import 'package:practica1/sign_in.dart';
import 'bloc/audio_bloc.dart';
import 'bloc/save_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: "sign_in",
      routes: {
        "recording": (context) => Recording(),
        "preview": (context) => Preview(),
        "saved_songs": (context) => SavedSongs(),
        "sign_in": (context) => SignIn(),
      },
    );
  }
}
