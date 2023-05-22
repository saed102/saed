import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  DefaultTextField({this.hint, this.controller,this.onChanged,this.inputType,this.obscure=false});

  String? hint;
  Function(String)? onChanged;
  bool? obscure ;
  TextEditingController? controller;
  TextInputType? inputType ;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: TextField(
        enabled: hint=="Address"?true:false,
        controller: controller,
        obscureText: obscure!,
        onChanged: onChanged,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: hint,
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(),

              borderRadius: BorderRadius.circular(10)),
          focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(),

              borderRadius: BorderRadius.circular(10)) ,
          border: OutlineInputBorder(
              borderSide: const BorderSide(),

              borderRadius: BorderRadius.circular(10)),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10) ,
            borderSide: const BorderSide(),

          ),
        ),
      ),
    );
  }
}
