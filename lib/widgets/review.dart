import 'package:comment_box/comment/comment.dart';
import 'package:cookbook/widgets/textfield.dart';
import 'package:flutter/material.dart';

final commentController = TextEditingController();
List comments = [];

Widget reviewWidget(){
  return Expanded(
    child: ListView(
        children: [
          for (var i = 0; i < comments.length; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    // Display the image in large form.
                    print("Comment Clicked");
                  },
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.all(Radius.circular(50))),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: CommentBox.commentImageParser(
                            imageURLorPath: 'pic')),
                  ),
                ),
                title: Text(
                 'name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(comments[i]),
                trailing: Text('date', style: TextStyle(fontSize: 10)),
              ),
            )
        ],
      ),
  );
  // return Expanded(child: CommentBox(
    
  //         userImage: CommentBox.commentImageParser(
  //             imageURLorPath: "assets/img/userpic.jpg"),
  //         child: 
  //         // // commentChild(filedata),
  //         // labelText: 'Write a comment...',
  //         // errorText: 'Comment cannot be blank',
  //         // withBorder: false,
  //         // sendButtonMethod: () {
  //         //   if (formKey.currentState!.validate()) {
  //         //     print(commentController.text);
  //         //     // setstate(() {
  //         //     //   var value = {
  //         //     //     'name': 'New User',
  //         //     //     'pic':
  //         //     //         'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
  //         //     //     'message': commentController.text,
  //         //     //     'date': '2021-01-01 12:00:00'
  //         //     //   };
  //         //       // filedata.insert(0, value);
  //         //     // });
  //         //     commentController.clear();
  //         //     FocusScope.of(context).unfocus();
  //         //   } else {
  //         //     print("Not validated");
  //         //   }
  //         // },
  //         formKey: formKey,
  //         commentController: commentController,
  //         backgroundColor: Colors.pink,
  //         textColor: Colors.white,
  //         sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        // ));
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
        controller: commentController,
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
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton(onPressed: () {
        onClickedAddComment();
      } ,
      backgroundColor:  Color.fromARGB(255, 196, 192, 192),child: Icon(
        
        Icons.send,),),
    )
  ],
),
  );
}

onClickedAddComment(){
  // comments.clear();
  comments.add(commentController.text);
  
}
