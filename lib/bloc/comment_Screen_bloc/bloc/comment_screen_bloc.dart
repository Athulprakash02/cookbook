import 'package:bloc/bloc.dart';
import 'package:cookbook/db/functions/comment_functions.dart';
import 'package:cookbook/db/model/comments_db.dart';
import 'package:meta/meta.dart';

part 'comment_screen_event.dart';
part 'comment_screen_state.dart';

class CommentScreenBloc extends Bloc<CommentScreenEvent, CommentScreenState> {
  CommentScreenBloc() : super(CommentScreenInitial(commentList: commentsList)) {
    on<AddComment>((event, emit) {
      // TODO: implement event handler
      commentsList.add(event.comment);
      return emit(CommentScreenState(commentList: commentsList));
    });
  }
}
