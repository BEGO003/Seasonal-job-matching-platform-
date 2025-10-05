import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  String? name;
  ProfileHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     AppColors.primary.withValues(alpha: .5),
          //     AppColors.accent.withValues(alpha: .2),
          //   ],
          // ),
          borderRadius: BorderRadiusDirectional.circular(30),
          // const BorderRadius.only(
          //   bottomLeft: Radius.circular(32),
          //   bottomRight: Radius.circular(32),
          // ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'profile_avatar',
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: .2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        color: AppColors.primaryLight,
                        //child should be image if there were one , if not should be icon
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Container(
                //       padding: const EdgeInsets.all(8),
                //       decoration: BoxDecoration(
                //         color: AppColors.primary,
                //         shape: BoxShape.circle,
                //         boxShadow: [
                //           BoxShadow(
                //             color: AppColors.shadow,
                //             blurRadius: 8,
                //             offset: const Offset(0, 2),
                //           ),
                //         ],
                //       ),
                //       // child: const Icon(
                //       //   Icons.camera_alt,
                //       //   size: 18,
                //       //   color: Colors.white,
                //       // ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            // here would be the name
            Text(
              name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 4),
            // Text(
            //   'Software Developer',
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
          ],
        ),
      ),
    );
  }
}
