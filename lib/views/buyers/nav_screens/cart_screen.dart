import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:courseflutter/utils/show.snackBar.dart';
import 'package:courseflutter/views/buyers/nav_screens/cash_out_screen.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/productCardItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;
  bool isLoading2 = false;

  late bool isLoading = false;

  List _productsCard = [];
  _getCard() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('users')
        .doc("uaryuEYmlMh1h14u1vS5P27w5DZ2")
        .collection("card")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        totalPrice += (double.parse(element.data()["product"]["price"].toString()) *
            int.parse(element.data()["quantity"].toString()));
        _productsCard.add(element.data());
      });
      print(_productsCard.length);
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    });
  }





  @override
  void initState() {
    _getCard();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Card",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color(0xFFF5F4F4),
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: Colors.orange,
      ));
    } else if (_productsCard.isNotEmpty && isLoading == false) {
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
                var cartProduct = _productsCard[index];
                return ProductsCartItem(cartProduct: cartProduct);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 2);
              },
              itemCount: _productsCard.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          totalPriceCard()
        ],
      );
    } else if (_productsCard.isEmpty && isLoading == false) {
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
              width: MediaQuery.of(context).size.width - 40,
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

  totalPriceCard() {
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
                  '${totalPrice} pound',
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
              child: isLoading2
                  ? SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      )))
                  : InkWell(
                      onTap: () {
                        //  addOrder();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CashOut(
                                    totalPrice: totalPrice,
                                    products: _productsCard)));
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
