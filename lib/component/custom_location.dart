import 'package:flutter/material.dart';

class CustomLocation extends StatelessWidget {
  const CustomLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Region'),
                    Text('Las Vegas'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
              child: VerticalDivider(width: 1, thickness: 1),
            ),
            Expanded(
              flex: 15,
              child: InkWell(
                onTap: () {},
                highlightColor: Colors.transparent,
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(
                    Icons.settings,
                    size: 24,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
              child: VerticalDivider(width: 1, thickness: 1),
            ),
            Expanded(
              flex: 15,
              child: InkWell(
                onTap: () {},
                highlightColor: Colors.transparent,
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(
                    Icons.location_on,
                    size: 24,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
