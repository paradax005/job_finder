import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/custom_textfield.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(kLight.value),
        ),
        title: CustomTextField(
          controller: searchController,
          hintText: "Search for a job",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(
              AntDesign.search1,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/optimized_search.png"),
            const HeightSpacer(size: 20),
            ReusableText(
              text: "Start Searching For Jobs",
              style: appstyle(22, Color(kDark.value), FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
