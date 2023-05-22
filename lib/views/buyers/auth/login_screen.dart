import 'package:courseflutter/controllers/auth_controller.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:courseflutter/utils/show.snackBar.dart';
import 'package:courseflutter/vendor/views/auth/vendor_auth.dart';
import 'package:courseflutter/views/buyers/auth/register_screen.dart';
import 'package:courseflutter/views/buyers/main_screen.dart';
import 'package:courseflutter/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => MainScreen()));
            isLoading = false;
          } else if (state is LoginFailure) {
            ShowSnackBar(context, state.errMessage);
            isLoading = false;
          }
        },
        child:
        Scaffold(
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login Customers"s Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      validator: (value ){
                        if(value!.isEmpty){
                          return 'Please Email Field must not be empty';
                        }else{
                          return null;
                        }
                      },
                      onChanged: ((value) {
                        email = value;
                      }),
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(

                      obscureText: true,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Password must not be empty';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .LoginUser(email: email!, password: password!);
                        }
                      },
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 40,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,)
                              : Text(
                            'Login',
                            style: TextStyle(
                              letterSpacing: 5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => VendorAuthScreen(),));
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade900,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                          color: Colors.white,)
                            : Text(
                          'Login as Vendor',
                          style: TextStyle(
                            letterSpacing: 5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Need Account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => BuyerRegisterScreen(),));
                        },
                        child: Text(
                          'Register',
                        ),
                      ),
                    ],)

                ],
              ),
            ),
          ),
        ));
  }
}


