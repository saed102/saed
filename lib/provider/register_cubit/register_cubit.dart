import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/register_cubit/app_model.dart';
import 'package:courseflutter/views/buyers/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> RegisterUser(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    try {
      emit(RegisterLoading());
      var userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await setDataUsersState(
          email: email, phone: phone, uid: userCred.user!.uid, name: name);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: 'email already in use'));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: 'there was an error please try again'));
    }
  }

  setDataUsersState({name, phone, uid, email}) {
    UserModel model =
        UserModel(uid: uid, name: name, phone: phone, email: email);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SetDataUsersState());
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
