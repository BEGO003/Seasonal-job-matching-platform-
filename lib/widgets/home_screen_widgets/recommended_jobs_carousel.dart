import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/widgets/home_screen_widgets/recommended_job_card.dart';

class RecommendedJobsCarousel extends StatelessWidget {
  final List<JobModel> jobs;

  const RecommendedJobsCarousel({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.85,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
      ),
      items: jobs.map((job) {
        return Builder(
          builder: (BuildContext context) {
            return RecommendedJobCard(job: job);
          },
        );
      }).toList(),
    );
  }
}
