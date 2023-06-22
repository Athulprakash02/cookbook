import 'package:bloc/bloc.dart';
import 'package:cookbook/db/functions/recently_viewed_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/user/recent_screen.dart';
import 'package:meta/meta.dart';

part 'recent_screen_event.dart';
part 'recent_screen_state.dart';

class RecentScreenBloc extends Bloc<RecentScreenEvent, RecentScreenState> {
  RecentScreenBloc() : super(RecentScreenInitial(recentList: recently)) {
    on<AddtoRecent>((event, emit) {
      // TODO: implement event handler
      recently.add(event.recipe);
      return emit(RecentScreenState(recentList: recently));
    });
  }
}
