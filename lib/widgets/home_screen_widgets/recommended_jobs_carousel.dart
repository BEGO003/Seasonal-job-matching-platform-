import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/widgets/home_screen_widgets/recommended_job_card.dart';

class RecommendedJobsCarousel extends StatefulWidget {
  final List<JobModel> jobs;

  const RecommendedJobsCarousel({super.key, required this.jobs});

  @override
  State<RecommendedJobsCarousel> createState() =>
      _RecommendedJobsCarouselState();
}

class _RecommendedJobsCarouselState extends State<RecommendedJobsCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Dribbble style usually likes slightly visible next card

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 480, // Increased height for airy layout
            viewportFraction: 0.85, // Show more of next card
            initialPage: 0,
            enableInfiniteScroll: widget.jobs.length > 1,
            reverse: false,
            autoPlay: widget.jobs.length > 1,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeOutQuart, // Smoother premium curve
            enlargeCenterPage: true, // Re-enabled for that focus effect
            enlargeFactor: 0.2, // Significant scale down for side items
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.jobs.map((job) {
            return RecommendedJobCard(job: job);
          }).toList(),
        ),

        const SizedBox(height: 24),

        _ModernPageIndicators(
          itemCount: widget.jobs.length,
          currentIndex: _currentIndex,
        ),
      ],
    );
  }
}

class _ModernPageIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const _ModernPageIndicators({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount > 5 ? 5 : itemCount, // Cap at 5 dots
        (index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 32 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? (isDark ? Colors.white : Colors.black)
                  : (isDark ? Colors.white24 : Colors.black12),
              borderRadius: BorderRadius.circular(100),
            ),
          );
        },
      ),
    );
  }
}
