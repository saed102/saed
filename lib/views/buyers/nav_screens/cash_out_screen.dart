import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:courseflutter/utils/show.snackBar.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/default_button.dart';
import 'package:flutter/material.dart';

class CashOut extends StatefulWidget {
  final double totalPrice;
  final List products;

  CashOut({Key? key, required this.totalPrice, required this.products})
      : super(key: key);

  @override
  State<CashOut> createState() => _CashOutState();
}

class _CashOutState extends State<CashOut> {
  late TextEditingController name;

  late TextEditingController phone;

  TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: LoginCubit.get(context).user!.name!);
    phone = TextEditingController(text: LoginCubit.get(context).user!.phone!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Cash out',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 100,
          ),
          DefaultTextField(
            controller: name,
            hint: 'Name',
            inputType: TextInputType.name,
          ),
          DefaultTextField(
            controller: phone,
            hint: 'Phone',
            inputType: TextInputType.number,
          ),
          DefaultTextField(
            controller: address,
            hint: 'Address',
            inputType: TextInputType.text,
          ),
          DefaultTextField(
            controller:
                TextEditingController(text: widget.products.length.toString()),
            hint: 'ProductsNum',
            inputType: TextInputType.text,
          ),
          DefaultTextField(
            controller:
                TextEditingController(text: widget.totalPrice.toString()),
            hint: 'Price',
            inputType: TextInputType.text,
          ),
          isLoading2
              ? Center(
                  child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(color: Colors.orange,),
                ))
              : DefaultButton(
                  text: 'Cash Out',
                  onTap: () {
                    if (address.text.isEmpty) {
                      showSnack(context, "enter address");
                    } else {
                      addOrder();

                    }
                  },
                ),
        ],
      ),
    );
  }

  bool isLoading2 = false;

  _deleteCard() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('users')
        .doc(LoginCubit.get(context).user!.uid)
        .collection("card")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    }).catchError((e) {});
  }

  addOrder() async {
    setState(() {
      isLoading2 = true;
    });
    var user = FirebaseFirestore.instance;

    await user.collection('order').add({
      "product": widget.products,
      "name": LoginCubit.get(context).user!.name,
      "id": LoginCubit.get(context).user!.uid,
      "phone": LoginCubit.get(context).user!.phone,
      "price": widget.totalPrice,
      "address": address.text,
    }).then((value) async {
      widget.products.clear();
      showSnack(context, "تم اضافة");
      await _deleteCard();


      setState(() {
        isLoading2 = false;
      });
    }).catchError((err) {
      print(err.toString());
      showSnack(context, 'حاول مرة اخرى');
      setState(() {
        isLoading2 = false;
      });
    });
  }
}

class DefaultButton extends StatelessWidget {
  DefaultButton({this.onTap, required this.text});

  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
