import 'package:bloc/bloc.dart';
import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:meta/meta.dart';

import '../../db/model/recipies.dart';

part 'add_recipe_event.dart';
part 'add_recipe_state.dart';

class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  AddRecipeBloc() : super(AddRecipeInitial(recipeList: recipeList)) {
    on<AddRecipe>((event, emit) {
      recipeList.add(event.list);
      return emit(AddRecipeState(recipeList: recipeList));
    });
  }
}
