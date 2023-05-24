import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/card_cubit.dart';
import 'package:courseflutter/provider/home_cubit.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCartItem extends StatelessWidget {
  const ProductsCartItem({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final Map cartProduct;




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCubit, CardState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Container(
          height: 85,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: Image.network(
                    cartProduct["product"]["image"][0],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cartProduct["product"]["name"] ?? "",
                      overflow: TextOverflow.ellipsis,
                      //   style: AppThemes.textStyle_3(14),
                    ),
                    Text(
                      cartProduct["product"]["discretion"],
                      // style: AppThemes.textStyle_3(9),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '${cartProduct["product"]["price"]} pound',
                          //  style: AppThemes.textStyle_7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              IconButton(
                onPressed: () {
                  CardCubit.get(context).delete(
                    cartProduct["id"], context,LoginCubit.get(context).user!.uid);
                },
                icon: Icon(Icons.delete),
                color: Colors.red,
              )
            ],
          ),
        );
      },
    );
  }
}
