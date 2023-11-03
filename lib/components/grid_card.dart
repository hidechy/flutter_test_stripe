import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/custom_theme.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.index, required this.press});

  final int index;
  final void Function() press;

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index.isEven ? const EdgeInsets.only(left: 15) : const EdgeInsets.only(right: 15),
      decoration: CustomTheme.getCardDecoration(),
      child: GestureDetector(
        onTap: press,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: 'http://toyohide.work/BrainLog/public/UPPHOTO/2014/2014-08-08/2014-08-08_001_l.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'title',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        'price',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
