import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/comments_db.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<CommentsData>> commentsListNotifier = ValueNotifier([]);
Future<void> addComment(CommentsData value) async {
  final commentsDB = await Hive.openBox<CommentsData>('comments_db');
  final comments = await commentsDB.add(value);
  value.id = comments;
  getAllComments();
  commentsListNotifier.value.add(value);
  commentsListNotifier.notifyListeners();
}

Future<void> getAllComments() async {
  final commentsDB = await Hive.openBox<CommentsData>('comments_db');
  commentsListNotifier.value.clear();
  commentsListNotifier.value.addAll(commentsDB.values);
  commentsListNotifier.notifyListeners();
}

onClickedAddComment(String commentTextController, username, recipename) {
  final commentText = commentTextController;
  final userName = username;
  final recipeName = recipename;

  print('clicked');

  final Comment = CommentsData(
      userName: userName,
      recipeName: recipeName,
      comment: commentTextController);
      addComment(Comment);

  // // comments.clear();
  // commentsList.add(commentController.text);
}
