import 'package:flutter/material.dart';

import '../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Storage Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Chart(),
          const StorageInfoCard(
            svgSrc: 'assets/icons/Documents.svg',
            title: 'Documents Files',
            amountOfFiles: '1.3GB',
            numOfFiles: 1328,
          ),
          const StorageInfoCard(
            svgSrc: 'assets/icons/media.svg',
            title: 'Media Files',
            amountOfFiles: '15.3GB',
            numOfFiles: 1328,
          ),
          const StorageInfoCard(
            svgSrc: 'assets/icons/folder.svg',
            title: 'Other Files',
            amountOfFiles: '1.3GB',
            numOfFiles: 1328,
          ),
          const StorageInfoCard(
            svgSrc: 'assets/icons/unknown.svg',
            title: 'Unknown',
            amountOfFiles: '1.3GB',
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}
