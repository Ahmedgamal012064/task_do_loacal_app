import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_do_local/views/models/note_model.dart';
import 'note_states.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteCubit extends Cubit<Notestates> {
  NoteCubit() : super(Noteinit());
  List<NoteModel>? allnotes;
  Color color = const Color(0xffAC3931);

  showToaster(String msg,Color background) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: background,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  addNote(NoteModel note) async {
    note.color = color.value;
    emit(Noteloading());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      await notesBox.add(note);
      emit(Notesuccess());
    }on Exception catch(e) {
      emit(Noteerror(e.toString()));
    }
   }

  allNotes() async {
    emit(Noteloading());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      allnotes = await notesBox.values.toList();
      if(notesBox.isEmpty){
        emit(Noteempty());
      }
      emit(Notesuccess());
    }on Exception catch(e) {
      emit(Noteerror(e.toString()));
    }
  }

  deleteNote(int index) async {
    emit(Noteloading());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      await notesBox.delete(index);
      emit(Notesuccess());
    }on Exception catch(e) {
      emit(Noteerror(e.toString()));
    }
  }
  }