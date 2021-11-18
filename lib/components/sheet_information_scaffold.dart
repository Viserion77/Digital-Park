import 'package:flutter/material.dart';

import 'image_flat_back.dart';

class SheetInformationScaffold extends StatelessWidget {
  SheetInformationScaffold({
    Key? key,
    this.floatingActionButton,
    this.imageUrl,
    this.title,
    required this.childrens,
  }) : super(key: key);

  final Widget? floatingActionButton;
  final String? imageUrl;
  final String? title;
  final List<Widget> childrens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        height: 60,
        child: floatingActionButton,
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: imageUrl != null ? 400 : null,
              flexibleSpace: FlexibleSpaceBar(
                background: imageUrl != null
                    ? ImageFlatBack(
                        image: imageUrl.toString(),
                      )
                    : null,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    50,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Flexible(
                        child: Text(
                          title.toString(),
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ...childrens
                    ],
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
