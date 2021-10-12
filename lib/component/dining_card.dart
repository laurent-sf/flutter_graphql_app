import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DiningCard extends StatelessWidget {
  /// Title of the card.
  final String title;

  /// Subtitle of the card.
  final String subtitle;

  /// Url of the image to display.
  final String? src;

  /// Function to execute on tap.
  final Function() onTap;

  const DiningCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.src,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 25,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    height: constraints.maxWidth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: src != null
                          ? CachedNetworkImage(
                              imageUrl: src!, fit: BoxFit.cover)
                          : Container(color: Colors.amberAccent),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
