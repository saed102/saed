import 'dart:typed_data';

import 'package:courseflutter/controllers/auth_controller.dart';
import 'package:courseflutter/provider/register_cubit/register_cubit.dart';
import 'package:courseflutter/utils/show.snackBar.dart';
import 'package:courseflutter/views/buyers/auth/login_screen.dart';
import 'package:courseflutter/views/buyers/main_screen.dart';
import 'package:courseflutter/utils/show_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class BuyerRegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String uid;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  //   _signUpUser()async{
  //     setState(() {
  //       _isLoading = true;
  //     });
  //   if(_formKey.currentState!.validate()){
  //       await _authController
  //       .signUpUsers(email, fullName, phoneNumber, password, _image)
  //       .whenComplete(() {
  //       setState(() {
  //         _formKey.currentState!.reset();
  //         _isLoading = false;
  //       });
  //     });
  //     return showSnack(
  //       context, 'Congratulations An Account Has Been Created For You');
  //   }else{
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return showSnack(context, 'Please Fields must not be empty');
  //   }
  // }
  //
  // selectGalleryImage()async{
  // Uint8List  im = await _authController.pickProfileImage(ImageSource.gallery);
  //
  //   _image = im ;
  //
  // }

  //_signUpUser()async{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is RegisterLoading) {
        _isLoading = true;
      } else if (state is RegisterSuccess) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
        _isLoading = false;
      } else if (state is RegisterFailure) {
        ShowSnackBar(context, state.errMessage);
        _isLoading = false;
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Customar"s Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.yellow.shade900,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.yellow.shade900,
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg'),
                            ),
                      Positioned(
                        right: 0,
                        top: 5,
                        child: IconButton(
                          onPressed: () {
                            // selectGalleryImage();
                          },
                          icon: Icon(
                            CupertinoIcons.photo,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Email Must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Full Name Must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        fullName = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Full Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Phone Number Must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Phone Number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Password Must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(context).RegisterUser(
                            email: email,
                            password: password,
                            name: fullName,
                            phone: phoneNumber);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4,
                                  ),
                                )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already Have An Account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text('Login'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
