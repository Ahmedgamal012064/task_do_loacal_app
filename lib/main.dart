import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_do_local/bloc/addnote/note_cubits.dart';
import 'package:task_do_local/views/models/note_model.dart';
import 'package:task_do_local/views/notes_views.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'observer.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = ObserverDart();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Do App Local',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: const NotesView(),
      ),
    );
  }
}
