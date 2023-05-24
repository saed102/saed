import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/controllers/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cate_state.dart';

class CateCubit extends Cubit<CateState> {
  CateCubit() : super(CateInitial());

  static CateCubit get(context) => BlocProvider.of(context);

  List<CateModel> _cate = [];
  void getCate()async{



    CollectionReference<Map<String, dynamic>> fireCate =  await FirebaseFirestore.instance.collection("categories");
    fireCate.get().then((value) {
      value.docs.forEach((element) {
        _cate = [];

        _cate.add(CateModel.fromJson(element.data()),);
        emit(getCateState());
      });
    }).catchError((e){
      e.toString();
      emit(cateErrState());
    });

  }


}
