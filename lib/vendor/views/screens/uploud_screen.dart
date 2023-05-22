import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/product_provider.dart';
import 'package:courseflutter/utils/show.snackBar.dart';
import 'package:courseflutter/vendor/views/screens/uploud_tap_screens/images_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'uploud_tap_screens/attributes_tab_screen.dart';
import 'uploud_tap_screens/general_screen.dart';
import 'uploud_tap_screens/shipping_screen.dart';

class UploudScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
    Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(
                child: Text('General'),
              ),
              Tab(
                child: Text('Shipping'),
              ),
              Tab(
                child: Text('Attributes'),
              ),
              Tab(
                child: Text('Images'),
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributesTabScreen(),
              ImagesTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow.shade900,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // print(_productProvider.productDate['productName']);
                  // print(_productProvider.productDate['productPrice']);
                  // print(_productProvider.productDate['quantity']);
                  // print(_productProvider.productDate['category']);
                  // print(_productProvider.productDate['description']);
                  // print(_productProvider.productDate['scheludeDate']);
                  // print(_productProvider.productDate['imageUrlList']);

                    FirebaseFirestore.instance.collection("products").add({
                      "name": _productProvider.productDate['productName'],
                      "discretion": _productProvider.productDate['description'],
                      "price": _productProvider.productDate['productPrice'],
                      "quantity": _productProvider.productDate['quantity'],
                      "image": _productProvider.productDate['imageUrlList'],
                      "category": _productProvider.productDate['category'],
                    }).then((value) {
                      showSnack(context, "product added ");
                    });
                  }

              },
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );

  }



  addProduct(context){

  }
}
