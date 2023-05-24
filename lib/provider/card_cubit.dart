// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'card_state.dart';
//
// class CardCubit extends Cubit<CardState> {
//   CardCubit() : super(CardInitial());
//
//
//   static CardCubit get(context) => BlocProvider.of(context);
//
//
//   getCard(context,id) async {
//     emit(Loading());
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     await _firestore
//         .collection('users')
//         .doc(LoginCubit.get(context).user!.uid)
//         .collection("card")
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         totalPrice += (double.parse(element.data()["product"]["price"].toString()) *
//             int.parse(element.data()["quantity"].toString()));
//         _productsCard.add(element.data());
//       });
//       print(_productsCard.length);
//       setState(() {
//         isLoading = false;
//       });
//     }).catchError((e) {
//       print(e.toString());
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//
//
//
//   delete(id) {
//     setState(() {
//       isLoading = true;
//     });
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(LoginCubit.get(context).user!.uid)
//         .collection("card")
//         .doc(id)
//         .delete()
//         .then((value) {})
//         .then((value)async {
//
//       await HomeCubit.get(context).getProducts();
//       setState(() {
//         isLoading = false;
//       });
//     }).catchError((onError) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//
// }
