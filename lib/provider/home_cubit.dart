import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  search(String value) async {
    if(value.isEmpty){
      getProducts();
    }else{
      List _products = [];

      await FirebaseFirestore.instance
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: value)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _products.add(element.data());
        });
        emit(Loaded(product: _products));
      });
    }


  }

  getProducts() async {
    List _products = [];
    emit(Loading());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('products').get().then((value) {
      value.docs.forEach((element) {
        _products.add(element.data());
      });

      emit(Loaded(product: _products));
    }).catchError((e) {});
  }
}
