import 'dart:ffi';

import 'package:comment_box/comment/comment.dart';
import 'package:cookbook/widgets/textfield.dart';
import 'package:flutter/material.dart';

final commentController = TextEditingController();
List commentsList = [];

// Widget reviewWidget() {
//   return Expanded(
//     child: ListView(
//       children: [
//         for (var i = 0; i < commentsList.length; i++)
//           Padding(
//             padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
//             child: ListTile(
//               leading: GestureDetector(
//                 onTap: () async {
//                   // Display the image in large form.
//                   print("Comment Clicked");
//                 },
//                 child: Container(
//                   height: 50.0,
//                   width: 50.0,
//                   decoration: const BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.all(Radius.circular(50))),
//                   child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage:
//                           CommentBox.commentImageParser(imageURLorPath: 'pic')),
//                 ),
//               ),
//               title: const Text(
//                 'name',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(commentsList[i]),
//               trailing: const Text('date', style: TextStyle(fontSize: 10)),
//             ),
//           )
//       ],
//     ),
//   );
// }

Widget commentBubble(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
    child: Container(
      width: double.maxFinite,
      
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('username',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Text('aduygfjkvfjkvuyvgJKBKBCGGVJGBJBJBCMBBaduygfjkvfjkvuyvgJKBKBCGGVJGBJBJBCMBBaduygfjkvfjkvuyvgJKBKBCGGVJGBJBJBCMBBaduygfjkvfjkvuyvgJKBKBCGGVJGBJBJBCMBBaduygfjkvfjkvuyvgJKBKBCGGVJGBJBJBCMBBaduygfjkvfjkvuyvgJKBKBCGGVJGBJBJBCMBB')),
          ],
        ),
      )
  
    ),
  );
}

Widget inputSection() {
  return Container(
    width: double.infinity,
    height: 80,
    color: const Color.fromARGB(255, 238, 200, 197),
    child: Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: TextField(
            controller: commentController,
            onSubmitted: (value) {},
            decoration: InputDecoration(
                hintText: 'Write review...',
                fillColor: const Color.fromARGB(255, 196, 192, 192),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {
              onClickedAddComment();
            },
            backgroundColor: const Color.fromARGB(255, 196, 192, 192),
            child: const Icon(
              Icons.send,
            ),
          ),
        )
      ],
    ),
  );
}

onClickedAddComment() {
  // comments.clear();
  commentsList.add(commentController.text);
}
