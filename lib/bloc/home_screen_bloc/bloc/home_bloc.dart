
import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db/model/recipies.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(recipeList: recipeList)) {
    on<AddRecipe>((event, emit) {
      recipeList.add(event.list);
      return emit(HomeState(recipeList: recipeList));
    });

    on<DeleteRecipe>((event, emit) {
      recipeList.remove(event.recipeId);
      return emit(HomeState(recipeList: recipeList));
    });

    on<UpdateRecipe>((event, emit) {
      recipeList.removeAt(event.index);
      recipeList.insert(event.index, event.value);

    });
  }
}
