import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/provider/login_cubit/login_cubit.dart';
import 'package:courseflutter/utils/show.snackBar.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/add_to_card.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/product.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/welcome_text_wedget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeText(),
        SizedBox(
          height: 14,
        ),
        SearchInputWidget(),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                BannerWidget(),
                CategoryText(),
                Products(),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

