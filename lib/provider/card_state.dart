part of 'card_cubit.dart';

@immutable
abstract class CardState {}

class CardInitial extends CardState {}
class Loading extends CardState {}
class Loaded extends CardState {}
