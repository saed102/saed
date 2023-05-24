part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class SearchHome extends HomeState {}
class Loading extends HomeState {}

class Loaded extends HomeState {
 final List product;
 Loaded({required this.product});
}
