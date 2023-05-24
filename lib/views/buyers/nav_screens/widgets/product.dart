import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../provider/login_cubit/login_cubit.dart';
import '../../../../utils/show.snackBar.dart';
import 'add_to_card.dart';

class Products extends StatefulWidget {
  const Products({Key? key,required this.product}) : super(key: key);
 final List product ;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isLoading = false;
  bool isCardLoading = false;
  int selectedIndex = -1;




  _addToCard(id) async {
    setState(() {
      isCardLoading = true;
      selectedIndex = id - 1;
    });
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('users')
        .doc(LoginCubit.get(context).user!.uid)
        .collection("card")
        .add({
      "product": widget.product[id - 1],
      "quantity": "1",
      "user_id": LoginCubit.get(context).user!.uid
    }).then((value) {
      showSnack(context, "success");

      setState(() {
        isCardLoading = false;
        selectedIndex = -1;
      });
    }).catchError((e) {
      showSnack(context, "fail");

      setState(() {
        isCardLoading = false;
      });
    });
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: Colors.orange,
      ));
    } else if (widget.product.isNotEmpty && isLoading == false) {
      return Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisExtent: 330,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 9 / 15,
          ),
          itemCount: widget.product.length,
          itemBuilder: (context, index) {
            return _buildProductItem(index);
          },
        ),
      );
    } else if (widget.product.isEmpty && isLoading == false) {
      return Center(child: Text("No data "));
    } else {
      return SizedBox();
    }
  }

  _buildProductItem(index) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  widget.product[index]["image"][0] ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product[index]["name"] ?? "non",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product[index]["discretion"] ?? "non",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      widget.product[index]["price"].toString() ?? "",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                if (selectedIndex != index)
                  AddToCartButton(
                    onPressed: () {
                      _addToCard(index + 1);
                    },
                  ),
                if (isCardLoading && selectedIndex == index)
                  Center(
                    child: SizedBox(
                        height: 22,
                        width: 22,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.orange,
                        ))),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
