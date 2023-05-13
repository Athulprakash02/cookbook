
import 'package:cookbook/db/functions/comment_functions.dart';
import 'package:cookbook/db/model/comments_db.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReviewScreen extends StatefulWidget {
   ReviewScreen({required this.recipe, super.key});

  final Recipes recipe;



  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late Box<CommentsData> commentList;


  List<CommentsData> commentLists = Hive.box<CommentsData>('comments_db').values.toList();
  late List<CommentsData> reviews = List<CommentsData>.from(commentLists);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    getAllComments();

  }
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // reviewWidget(),
              Expanded(child: ValueListenableBuilder(
                valueListenable: commentsListNotifier,
                builder: (context, List<CommentsData> reviews, child) {
                      final matchingReviews = reviews.where((review) => review.recipeName == widget.recipe.recipeName).toList();

                  return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = matchingReviews[index];
                  return commentBubble(data);
                },
                itemCount: matchingReviews.length,);
                }  
                
              )
              ),
              inputSection(widget.recipe)
              
            ],
          ),
        ),
      )),
    );
  }
}