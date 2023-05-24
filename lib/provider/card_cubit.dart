import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());


  static CardCubit get(context) => BlocProvider.of(context);

  double totalPrice = 0;


  List productsCard = [];
  getProductCard(context) async {
    emit(Loading());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('users')
        .doc(LoginCubit.get(context).user!.uid)
        .collection("card")
        .get()
        .then((value) {
          totalPrice = 0;
      value.docs.forEach((element) {
        totalPrice += (double.parse(element.data()["product"]["price"].toString()) *
            int.parse(element.data()["quantity"].toString()));
        productsCard.add(element.data());
      });
      emit(Loaded());
    }).catchError((e) {
      emit(Loaded());
    });
  }







  delete(id,context,uid) {
    emit(Loading());

    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("card")
        .doc(id)
        .delete()
        .then((value)async {

     await getProductCard(context);
     emit(Loaded());

    }).catchError((onError) {
   print(onError.toString());
    });
  }


}


