

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 final List<String> _categoryList = [];
_getCategoris(){
  return _firestore
   .collection('categories')
   .get().then((QuerySnapshot querySnapshot){
 querySnapshot.docs.forEach((doc) { 
    setState(() {
      _categoryList.add(doc['categoryName']);
    });
    });
  });
}

@override
  void initState() {
    _getCategoris();
    super.initState();
  }

  String formatedDate(date){
    final outPutDateFormate =DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
     Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Enter Pruduct Name';
                  }else{
                    return null;
                  }
                }),
                onChanged: (value){
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Pruduct Name',
                ),
              ),
              SizedBox(
                height: 30,
                ),
              TextFormField(
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Enter Pruduct price';
                  }else{
                    return null;
                  }
                }),
                onChanged: (value) {
                  _productProvider.getFormData(productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Pruduct price',
                ),
              ),
              SizedBox(
                height: 30,
                ),
               TextFormField(
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Enter Pruduct Quantity';
                  }else{
                    return null;
                  }
                }),
                onChanged: (value) {
                  _productProvider.getFormData(quantity: int.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Enter Pruduct Quantity',
                ),
              ),
              SizedBox(
                height: 30,
                ),
              DropdownButtonFormField(
                hint: Text('Select Category'),
                items: _categoryList.map<DropdownMenuItem<String>>((e){
                return DropdownMenuItem(
                  value: e,
                  child: Text(e));
              }).toList(),
               onChanged: (value){
                setState(() {
                  _productProvider.getFormData(category: value);
                });
               }),
        
               SizedBox(
                height: 30,
                ),
               TextFormField(
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Enter Pruduct Description';
                  }else{
                    return null;
                  }
                }),
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                minLines: 3,
                maxLines: 10,
                maxLength: 800,
                decoration:
                 InputDecoration(
                  labelText: 'Enter Pruduct Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  ),
               ),

               Row(
                children: [
                 TextButton(
                  onPressed: (){
                    showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime.now(), 
                      lastDate: DateTime(5000))
                      .then((value){
                      setState(() {
                        _productProvider.getFormData(scheduleDate: value);
                      });
                      });
                  }, 
                  child: Text('Schede'),
                  ),
                  if (_productProvider.productDate['scheduleDate'] != null)
                  Text(
                    formatedDate(
                      _productProvider.productDate['scheduleDate'],
                 ),
                ),
               ],
              ),
            ],
          ),
        ),
      )
    );
  }
}