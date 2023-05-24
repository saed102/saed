import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/controllers/category_model.dart';
import 'package:courseflutter/provider/cate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CateCubit(),
      child: BlocConsumer<CateCubit, CateState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = CateCubit.get(context);
          return Scaffold(

              body: Center(
                child: Container(

                ),
              )

          );
        },
      ),
    );
  }


}