import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String svgSrc, title, totalStorage;
  final int numOfFiles, percentage;
  final Color color;

  CloudStorageInfo({
    required this.svgSrc,
    required this.title,
    required this.totalStorage,
    required this.numOfFiles,
    required this.percentage,
    required this.color,
  });
}

List<CloudStorageInfo> demoFields(BuildContext context) => <CloudStorageInfo>[
      CloudStorageInfo(
        title: 'Documents',
        numOfFiles: 1328,
        svgSrc: 'assets/icons/Documents.svg',
        totalStorage: '1.9GB',
        color: Theme.of(context).accentColor,
        percentage: 35,
      ),
      CloudStorageInfo(
        title: 'Google Drive',
        numOfFiles: 1328,
        svgSrc: 'assets/icons/google_drive.svg',
        totalStorage: '2.9GB',
        color: const Color(0xFFFFA113),
        percentage: 35,
      ),
      CloudStorageInfo(
        title: 'One Drive',
        numOfFiles: 1328,
        svgSrc: 'assets/icons/one_drive.svg',
        totalStorage: '1GB',
        color: const Color(0xFFA4CDFF),
        percentage: 10,
      ),
      CloudStorageInfo(
        title: 'Dropbox',
        numOfFiles: 5328,
        svgSrc: 'assets/icons/drop_box.svg',
        totalStorage: '7.3GB',
        color: const Color(0xFF007EE5),
        percentage: 78,
      ),
    ];
