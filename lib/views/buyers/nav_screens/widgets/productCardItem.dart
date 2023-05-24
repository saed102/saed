import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/home_cubit.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';

class ProductsCartItem extends StatefulWidget {
  const ProductsCartItem({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final Map cartProduct;

  @override
  State<ProductsCartItem> createState() => _ProductsCartItemState();
}

class _ProductsCartItemState extends State<ProductsCartItem>
{
  late TextEditingController controller;

  @override
  void initState() {

    controller = TextEditingController()
      ..text = widget.cartProduct["quantity"].toString();
    super.initState();
  }

  bool isLoading = false;

  delete(id) {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(LoginCubit.get(context).user!.uid)
        .collection("card")
        .doc(id)
        .delete()
        .then((value) {})
        .then((value)async {

         await HomeCubit.get(context).getProducts();
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
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
                widget.cartProduct["product"]["image"][0],
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
                  widget.cartProduct["product"]["name"] ?? "",
                  overflow: TextOverflow.ellipsis,
                  //   style: AppThemes.textStyle_3(14),
                ),
                Text(
                  widget.cartProduct["product"]["discretion"],
                  // style: AppThemes.textStyle_3(9),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${widget.cartProduct["product"]["price"]} pound',
                      //  style: AppThemes.textStyle_7,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          isLoading?CircularProgressIndicator(color: Colors.orange,):
          IconButton(
            onPressed: () {
              delete(widget.cartProduct["id"]);
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
