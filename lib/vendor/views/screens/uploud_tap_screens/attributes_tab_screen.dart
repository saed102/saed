

import 'package:courseflutter/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributesTabScreen extends StatefulWidget {
  @override
  State<AttributesTabScreen> createState() => _AttributesTabScreenState();
}

class _AttributesTabScreenState extends State<AttributesTabScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _entered = false;
  List<String> _codeList = [];
  bool _isSave = false;
  

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
     Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter Brand';
                  }else{
                    return null;
                  }
                },
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(
              labelText: 'Brand'
            ),
          ),
          SizedBox(
            height: 10,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter Code';
                  }else{
                    return null;
                  }
                },
                    controller: _codeController,
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Code'
                    ),
                  ),
                ),
              ),
              _entered == true
                ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade900,
                ),
                onPressed: (){
                  setState(() {
                    _codeList.add(_codeController.text);
                    _codeController.clear();
                  });
                  print(_codeList);
                }, 
                child: Text(
                  'Add',
                  ),
                )
                :Text(''),
            ],
          ),
       if(_codeList.isNotEmpty)
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
            height: 50,
             child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _codeList.length,
              itemBuilder: ((context, index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: InkWell(
                  onTap: (){
                    setState(() {
                      _codeList.removeAt(index);
                      _productProvider.getFormData(codeList: _codeList);
                    });
                  },
                   child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade800,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _codeList[index],
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                   ),
                 ),
               );
             }),
            ),
           ),
         ),
         if(_codeList.isNotEmpty)
         ElevatedButton(
          onPressed: (){
            _productProvider.getFormData(codeList: _codeList);
            setState(() {
              _isSave = true;
            });
          },
           child:
            Text(
             _isSave  ? 'Saved': 'Save',
             style:
              TextStyle(
                fontWeight: FontWeight.bold,
                ),
            ),
          ),
        ],
      ),
    );
  }
}