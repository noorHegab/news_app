import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  String? selectedCategory;

  void selectCategory(String? category) {
    selectedCategory = category;
    emit(CategorySuccessState());
  }
}
