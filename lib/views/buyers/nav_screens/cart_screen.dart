import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/card_cubit.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';

import 'package:courseflutter/views/buyers/nav_screens/cash_out_screen.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/productCardItem.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});









  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit()..getProductCard(context),
      child: BlocConsumer<CardCubit, CardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Card",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Color(0xFFF5F4F4),
            body: _buildBody(context,state),
          );
        },
      ),
    );
  }

  _buildBody(context,state) {
    if (state is Loading) {
      return Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ));
    } else if (CardCubit.get(context).productsCard.isNotEmpty && state is Loaded ) {
      return Column(
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 25),
              Text(
                "products",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var cartProduct = CardCubit.get(context).productsCard[index];
                return ProductsCartItem(cartProduct: cartProduct);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 2);
              },
              itemCount: CardCubit.get(context).productsCard.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          totalPriceCard(context)
        ],
      );
    } else if (CardCubit.get(context).productsCard.isEmpty && state is Loaded) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Shopping Cart is Empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  totalPriceCard(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'cart total',
                style: TextStyle(fontSize: 15),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  '${CardCubit.get(context).totalPrice} pound',
                ),
              ),
            ],
          ),
          const Divider(thickness: 2),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: InkWell(
                onTap: () {
                  //  addOrder();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CashOut(
                                  totalPrice: CardCubit.get(context).totalPrice,
                                  products: CardCubit.get(context).productsCard)));
                },
                child: Text(
                  'Cash Out',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}


// updateProductInCart(BuildContext context,
//     {required int userId, required int productId, required int productNum}) {
//   BlocProvider.of<GetCartProductsBloc>(context).add(UpdateProductToCartEvent(
//     userId: userId,
//     productId: productId,
//     productNum: productNum,
//   ));
