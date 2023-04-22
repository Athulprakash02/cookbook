import 'package:cookbook/widgets/textfield.dart';
import 'package:flutter/material.dart';


Widget reviewWidget(){
  return Expanded(child: Container());
}

Widget inputSection(){
  return Container(
width: double.infinity,
height: 80,
color: Color.fromARGB(255, 238, 200, 197),
child: Row(
  children: [
    Expanded(child: Padding(
      padding: const EdgeInsets.only(left: 13),
      child: TextField(
        onSubmitted: (value) {
          
        },
        decoration: InputDecoration(
          hintText: 'Write review...',
          fillColor: Color.fromARGB(255, 196, 192, 192),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50)
          )
        ),
      ),
    )),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(onPressed: () {
        
      } ,
      backgroundColor:  Color.fromARGB(255, 196, 192, 192),child: Icon(Icons.send),),
    )
  ],
),
  );
}
