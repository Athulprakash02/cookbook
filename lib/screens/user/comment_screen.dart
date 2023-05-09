import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReviewScreen extends StatefulWidget {
   ReviewScreen({required this.recipe, super.key});

  final Recipes recipe;


  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
              Expanded(child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                return commentBubble();
              },
              itemCount: 10,)
              ),
              inputSection()
              
            ],
          ),
        ),
      )),
    );
  }
}