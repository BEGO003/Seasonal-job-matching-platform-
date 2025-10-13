import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const DocumentCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    // final String? fileName;
    // final String? fileSize;
    // final String? lastUpdated;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    bool isThereFile = true;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 15.0),
                  CircleAvatar(
                    backgroundColor: colorScheme.primary.withValues(alpha: .1),
                    foregroundColor: colorScheme.primary,
                    radius: 26,
                    child: Icon(icon, size: 22),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isThereFile) ...[
                        Text(
                          // 'File Name : ${ fileName ?? 'No File Name'}',
                          'File Name : No File Name',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          // 'File Size : ${fileSize ?? 'No File Size'}',
                          'File Size : No File Size',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          // 'Last Updated : ${lastUpdated ?? 'No Last Updated'}',
                          'Last Updated : No Last Updated',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: TextButton(onPressed: () {}, child: Text('Upload')),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: FilledButton(
                      onPressed: ()  {
                        // final Dio dio = Dio(
                        //   BaseOptions(
                        //     baseUrl: "http://192.168.1.44:3000/users/",
                        //     connectTimeout: const Duration(seconds: 10),
                        //     receiveTimeout: const Duration(seconds: 10),
                        //     headers: {'Content-Type': 'application/json'},
                        //   ),
                        // );
                        // final Response response = await dio.get('usr_001');
                        // print(" Here is ${response.data}");
                      },
                      child: Text('View'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
