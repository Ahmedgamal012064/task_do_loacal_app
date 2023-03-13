import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_do_local/widget/body_notes_widget.dart';
import 'package:task_do_local/bloc/addnote/note_cubits.dart';
import 'package:task_do_local/bloc/addnote/note_states.dart';
import 'package:task_do_local/views/models/note_model.dart';
import '../widget/bottom_sheet.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NoteCubit>(context).allNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[300],
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context, builder: (context){
            return BottomSheetBody();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
            children: [
              SizedBox(height: 75,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Note App',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Center(
                          child: Icon(Icons.search,size: 30,),
                        ),
                    ),
                  ],
                ),
              BlocBuilder<NoteCubit,Notestates>(
                builder: (context,state) {
                  List<NoteModel> notes = BlocProvider.of<NoteCubit>(context).allnotes ?? [];
                  if (state is Noteerror) {
                    BlocProvider.of<NoteCubit>(context).showToaster(
                        'error :${state.errMessage}',
                        Colors.red
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: state is Notesuccess ? notes.length : 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: BodyNotes(
                              note: notes[index],
                            ),
                          );
                        }
                    ),
                  );
                }
              ),
            ],
          ),
      ),
    );
  }
}
