import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/models/response/jobs/job_response.dart';
import 'package:job_finder/services/helpers/jobs_helper.dart';
import 'package:job_finder/views/common/custom_textfield.dart';
import 'package:job_finder/views/ui/jobs/widget/job_vertical_tile.dart';

import '../../common/loader.dart';

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
          containerColor: Colors.transparent,
          hintColor: Colors.white,
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
      body: searchController.text.isEmpty
          ? const Loader(message: "Start Searching For Jobs")
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJob(searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return const Loader(message: "No Jobs Found");
                  } else {
                    var jobs = snapshot.data;
                    return ListView.builder(
                      itemCount: jobs!.length,
                      itemBuilder: (context, index) {
                        JobsResponse job = jobs[index];
                        return JobVerticalTile(job: job);
                      },
                    );
                  }
                },
              ),
            ),
    );
  }
}
