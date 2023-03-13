import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/addnote/note_cubits.dart';

class colorItems extends StatefulWidget {
  const colorItems({Key? key}) : super(key: key);

  @override
  State<colorItems> createState() => _colorItemsState();
}

class _colorItemsState extends State<colorItems> {
  Color isActiveColor = Color(0xffAC3931);
  int current_color_select = 0;
  List<Color>  colors = [
    Color(0xffAC3931),
    Color(0xffE5D352),
    Color(0xffD9E76c),
    Color(0xff537D8D),
    Color(0xff482C3D),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38*2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context,index){
          if(current_color_select == index){
            isActiveColor = colors[index];
          }
          return GestureDetector(
            onTap: (){
              current_color_select = index;
              BlocProvider.of<NoteCubit>(context).color = colors[index];
              isActiveColor = colors[current_color_select];
              print(current_color_select);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: isActiveColor ==  colors[index] ? CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: colors[index],
                ),
              ) : CircleAvatar(
                radius: 32,
                backgroundColor: colors[index],
              ),
            ),
          );
        },
      ),
    );
  }
}