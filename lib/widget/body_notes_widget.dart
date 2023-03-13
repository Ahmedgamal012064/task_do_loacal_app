import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_do_local/bloc/addnote/note_cubits.dart';
import 'package:task_do_local/bloc/addnote/note_states.dart';
import 'package:task_do_local/views/models/note_model.dart';

class BodyNotes extends StatelessWidget {
  final NoteModel note;
  const BodyNotes({Key? key,required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 24,
        left: 16,
      ),
      decoration: BoxDecoration(
          color:Color(note.color!) ,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(note.title,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
            subtitle:Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 16),
              child: Text(note.content,style: TextStyle(
                fontSize: 20,
              ), ),
            ) ,
            trailing: BlocBuilder<NoteCubit,Notestates>(
              builder: (context,state) {
                return IconButton(
                    onPressed: (){
                      note.delete();
                      BlocProvider.of<NoteCubit>(context).allNotes();
                    },
                    icon: Icon(Icons.delete,color: Colors.black,size: 28,),
                );
              }
            ),
          ),
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(note.date,style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),),
          ),
        ],
      ),
    );
  }
}
