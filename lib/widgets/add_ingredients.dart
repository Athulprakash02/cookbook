import 'package:flutter/material.dart';

Widget defaultaddIngredients() {
  return SizedBox(
    height: 52,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Add ingredients',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        IconButton(
          onPressed: () {
            
          },
          icon: Icon(Icons.add_box_outlined),
          iconSize: 35,
        )
      ],
    ),
  );
}



  // Widget addIngredients(int index,[GlobalKey? key]) {
  //   ObjectKey keys = ObjectKey({});
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 4, bottom: 4),
  //     child: SizedBox(
  //       height: 52,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: TextField(
  //               controller: _controllers[index],
  //               key: keys,
  //               decoration: InputDecoration(
  //                   suffixIcon: IconButton(
  //                       onPressed: () {
  //                         if(key!= null){
  //                           removeTextField(key);

  //                         }
                          
  //                       },
  //                       icon: Icon(Icons.clear)),
  //                   hintText: 'Add ingredients',
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(10))),
  //             ),
  //           ),
  //           IconButton(
  //             onPressed: () {
  //               addTextField(index + 1);
  //             },
  //             icon: Icon(Icons.add_box_outlined),
  //             iconSize: 35,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }


