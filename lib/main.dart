
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:courseflutter/provider/product_provider.dart';
import 'package:courseflutter/provider/register_cubit/register_cubit.dart';
import 'package:courseflutter/vendor/views/auth/vendor_auth.dart';
import 'package:courseflutter/vendor/views/screens/main_vendor_screen.dart';
import 'package:courseflutter/views/buyers/auth/login_screen.dart';
import 'package:courseflutter/views/buyers/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_){
        return ProductProvider();
      })
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
        providers: [
        BlocProvider(
        create: (context) => LoginCubit(),
    ),
    BlocProvider(
    create: (context) => RegisterCubit(),
    ),
    ],
    child:
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      home: LoginScreen(),
       builder: EasyLoading.init(),

    ));
  }
}
