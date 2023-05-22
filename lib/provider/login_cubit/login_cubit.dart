import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/register_cubit/app_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

 static LoginCubit get(context) => BlocProvider.of(context);

  Future LoginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await getDataUser(userCred.user!.uid);
      emit(LoginSuccess());

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'wrong password'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'some thing went error'));
    }
  }


  UserModel? user;

  getDataUser(id) {
    FirebaseFirestore.instance.collection("users").doc(id).get().then((value) {
      Map<String, dynamic>   json= value.data()!;

      user=  UserModel.fromJson(json);

      print(user!.name);
    });
  }

}

