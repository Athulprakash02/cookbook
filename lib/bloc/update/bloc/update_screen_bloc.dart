import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_screen_event.dart';
part 'update_screen_state.dart';

class UpdateScreenBloc extends Bloc<UpdateScreenEvent, UpdateScreenState> {
  UpdateScreenBloc() : super(UpdateScreenInitial()) {
    on<UpdateScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
