import 'package:cookbook/widgets/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            reviewWidget(),
            inputSection()
            
          ],
        ),
      )),
    );
  }
}