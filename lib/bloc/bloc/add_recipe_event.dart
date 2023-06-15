part of 'add_recipe_bloc.dart';

@immutable
abstract class AddRecipeEvent {}

class AddRecipe extends AddRecipeEvent {
  final Recipes list;

  AddRecipe({required this.list});
}

