import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_textfeild_event.dart';
part 'add_textfeild_state.dart';

class AddTextfeildBloc extends Bloc<AddTextfeildEvent, AddTextfeildState> {
  AddTextfeildBloc() : super(AddTextfeildInitial()) {
    on<AddTextfeildEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
