// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';

class StubData {
  static const List<Place> places = [
    Place(
      id: '1',
      latLng: LatLng(45.524676, -122.681922),
      name: 'Pedalinhos',
      description: 'Pedalinhos da lagoa',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
  ];

  static const reviewStrings = <String>[
    'Teste',
    'Teste2',
  ];
}
