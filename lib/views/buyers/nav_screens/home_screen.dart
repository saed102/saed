import 'package:courseflutter/provider/home_cubit.dart';

import 'package:courseflutter/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:courseflutter/views/buyers/nav_screens/widgets/welcome_text_wedget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
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
                      if(state is Loading)
                        CircularProgressIndicator(),
                      if(state is Loaded)
                      // Products(products: state.product),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

