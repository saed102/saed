// ignore_for_file: unused_import

import 'package:courseflutter/views/buyers/nav_screens/account_screen.dart';
import 'package:courseflutter/views/buyers/nav_screens/cart_screen.dart';
import 'package:courseflutter/views/buyers/nav_screens/category_screen.dart';
import 'package:courseflutter/views/buyers/nav_screens/search_screen.dart';
import 'package:courseflutter/views/buyers/nav_screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'nav_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 int _pageIndex = 0;

 List<Widget> _pages  = [
   HomeScreen(),
   CategoryScreen(),
   StoreScreen(),
   CartScreen(),
   SearchScreen(),
   AccountScreen(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value ;
          });
        } ,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,

        items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
          ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/explore.svg',
            width: 20,
            color: _pageIndex==1?Colors.yellow.shade900:Colors.black,

            ),
          label: 'Categories',
          ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/shop.svg',
            width: 20,
            color: _pageIndex==2?Colors.yellow.shade900:Colors.black,

          ),
          label: 'Store',
          ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/cart.svg',
            width: 20,
            color: _pageIndex==3?Colors.yellow.shade900:Colors.black,

          ),
          label: 'Cart',
          ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/search.svg',
            width: 20,
            color: _pageIndex==4?Colors.yellow.shade900:Colors.black,

          ),
          label: 'Search',
          ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/account.svg',
            width: 20,
            color: _pageIndex==5?Colors.yellow.shade900:Colors.black,

          ),
          label: 'Account',
          ),  
      ],
      ),
      body: _pages[_pageIndex],
    );
  }
}