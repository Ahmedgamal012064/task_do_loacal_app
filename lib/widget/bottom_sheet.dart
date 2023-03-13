import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_do_local/bloc/addnote/note_cubits.dart';
import 'package:task_do_local/bloc/addnote/note_states.dart';
import 'package:task_do_local/views/models/note_model.dart';
import 'package:intl/intl.dart';
import 'color_item_widget.dart';
import 'custom_text_field.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({Key? key}) : super(key: key);

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  bool isLoading = false;
  GlobalKey<FormState> formKey  = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title,subtitle;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child:  SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 32,),
                  CusomTextField(hint: "Enter Title Here",maxLine: 2, onSaved: (value){ title = value;}),
                  SizedBox(height: 25,),
                  CusomTextField(hint: "Enter Content Here",maxLine: 5,onSaved: (value){ subtitle = value;}),
                  SizedBox(height: 35,),
                  colorItems(),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child:
                      BlocBuilder<NoteCubit,Notestates>(builder: (context,state){
                        return TextButton(onPressed: (){
                          if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          var currentdate = DateTime.now();
                          var formatcurrentdate = DateFormat('yyyy-MM-dd – kk:mm').format(currentdate);
                          var note = NoteModel(
                              title: title!,
                              content: subtitle!,
                              date: formatcurrentdate,
                              color: Colors.red.value
                          );
                          BlocProvider.of<NoteCubit>(context).addNote(note);
                          if(state is Noteloading) {
                            isLoading = true;
                          }
                          if( state is Noteerror) {
                            isLoading = false;
                            BlocProvider.of<NoteCubit>(context).showToaster(
                                'error :${state.errMessage}',
                              Colors.red
                            );
                          }
                          if(state is Notesuccess) {
                            isLoading = false;
                            BlocProvider.of<NoteCubit>(context).showToaster(
                                'Success Add Notes',
                                Colors.green
                            );
                            BlocProvider.of<NoteCubit>(context).allNotes();
                            Navigator.pop(context);
                          }
                        }else{
                          autovalidateMode = AutovalidateMode.always;
                        }
                        setState(() {});
                      },
                          child: Text('Save',style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                      ),
                      );
                      }),
                    ),
                  ),
                  SizedBox(height: 15,),

                ],
              ),
          ),
        ),
      ),
    );
  }
}

