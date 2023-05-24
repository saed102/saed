import 'package:courseflutter/provider/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

List<dynamic> search = [];

class _SearchInputWidgetState extends State<SearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          onChanged: (value) {

            HomeCubit.get(context).search(value);


          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search For Products',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 10,
                ),
              )),
        ),
      ),
    );
  }
}
