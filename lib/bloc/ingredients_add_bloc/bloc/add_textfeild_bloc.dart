import 'package:bloc/bloc.dart';
import 'package:cookbook/screens/managing/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_textfeild_event.dart';
part 'add_textfeild_state.dart';

class AddTextfeildBloc extends Bloc<AddTextfeildEvent, AddTextfeildState> {
  AddTextfeildBloc() : super(AddTextfeildInitial()) {
    on<AddIngredientsTextFeild>((event, emit) {
      print('ivde vann');
      // // TODO: implement event handler
      // GlobalKey key = ;
      controllers.add(TextEditingController());
      textKeys.add(GlobalKey());
      print(textKeys.length);
      textfields.add(addIngredients(GlobalKey()));
      print("uhbshb${textfields.length}");
      // _ingredientsList.clear();
      ingredientsList.add('');
      

      return emit(AddTextfeildState(textFields: textfields, controllers: controllers, textKeys: textKeys, ingredientsList: ingredientsList));
      


    });
  }
}
