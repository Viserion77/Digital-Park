import 'package:digital_park/components/basics.dart';
import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/models/wayPiont.dart';
import 'package:flutter/material.dart';

class WayPointPlace extends StatelessWidget {
  final WayPoint wayPoint;

  const WayPointPlace({Key key, this.wayPoint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              wayPoint.name != null ? wayPoint.name : 'Localização',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'images/logo.png',
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 240.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(wayPoint.image != null
                      ? wayPoint.image
                      : "http://grupomalwee.s3.amazonaws.com/uploads/midias/original/1320.jpg"),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFunction(
                  label: 'Rotas',
                  icon: Icons.directions,
                ),
                TextFunction(
                  label: 'Ranking',
                  icon: Icons.star,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  wayPoint.description != null
                      ? wayPoint.description
                      : 'Localização',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenuBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star_border),
      ),
    );
  }
}
