import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_favourite_event.dart';
part 'add_favourite_state.dart';

class AddFavouriteBloc extends Bloc<AddFavouriteEvent, AddFavouriteState> {
  AddFavouriteBloc() : super(AddFavouriteInitial(favouriteStatus: {})) {
    on<FavouritedEvent>((event, emit) {
      // TODO: implement event handler
      final recipeName = event.recipeName;
      final isFavourite = state.favouriteStatus[recipeName] ?? false;
      
      final bool updatedStatus = !isFavourite;

      final Map<String,bool> updatedFavouriteStatus ={ ...state.favouriteStatus, recipeName: updatedStatus};

      return emit(AddFavouriteState(favouriteStatus: updatedFavouriteStatus));


    });
  }
}
