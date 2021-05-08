// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'place.dart';
import 'place_details.dart';
import 'place_tracker_app.dart';

class MapConfiguration {
  final List<Place> places;

  final PlaceCategory selectedCategory;

  const MapConfiguration({
    @required this.places,
    @required this.selectedCategory,
  })  : assert(places != null),
        assert(selectedCategory != null);

  @override
  int get hashCode => places.hashCode ^ selectedCategory.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MapConfiguration &&
        other.places == places &&
        other.selectedCategory == selectedCategory;
  }

  static MapConfiguration of(AppState appState) {
    return MapConfiguration(
      places: appState.places,
      selectedCategory: appState.selectedCategory,
    );
  }
}

class PlaceMap extends StatefulWidget {
  final LatLng center;

  const PlaceMap({
    Key key,
    this.center,
  }) : super(key: key);

  @override
  PlaceMapState createState() => PlaceMapState();
}

class PlaceMapState extends State<PlaceMap> {
  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  final Map<Marker, Place> _markedPlaces = <Marker, Place>{};

  final Set<Marker> _markers = {};

  MapConfiguration _configuration;

  @override
  Widget build(BuildContext context) {
    _maybeUpdateMapConfiguration();

    return Builder(builder: (context) {
      // We need this additional builder here so that we can pass its context to
      // _AddPlaceButtonBar's onSavePressed callback. This callback shows a
      // SnackBar and to do this, we need a build context that has Scaffold as
      // an ancestor.
      return Center(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
            ),
          ],
        ),
      );
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);

    // Draw initial place markers on creation so that we have something
    // interesting to look at.
    var markers = <Marker>{};
    for (var place in Provider.of<AppState>(context, listen: false).places) {
      markers.add(await _createPlaceMarker(context, place));
    }
    setState(() {
      _markers.addAll(markers);
    });

    // Zoom to fit the initially selected category.
    _zoomToFitSelectedCategory();
  }

  @override
  void didUpdateWidget(PlaceMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Zoom to fit the selected category.
    if (mounted) {
      _zoomToFitSelectedCategory();
    }
  }

  /// Applies zoom to fit the places of the selected category
  void _zoomToFitSelectedCategory() {
    _zoomToFitPlaces(
      _getPlacesForCategory(
        Provider.of<AppState>(context, listen: false).selectedCategory,
        _markedPlaces.values.toList(),
      ),
    );
  }

  Future<Marker> _createPlaceMarker(BuildContext context, Place place) async {
    final marker = Marker(
      markerId: MarkerId(place.latLng.toString()),
      position: place.latLng,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: '${place.starRating} Star Rating',
        onTap: () => _pushPlaceDetailsScreen(place),
      ),
      icon: await _getPlaceMarkerIcon(context, place.category),
      visible: place.category ==
          Provider.of<AppState>(context, listen: false).selectedCategory,
    );
    _markedPlaces[marker] = place;
    return marker;
  }

  Future<void> _maybeUpdateMapConfiguration() async {
    _configuration ??=
        MapConfiguration.of(Provider.of<AppState>(context, listen: false));
    final newConfiguration =
        MapConfiguration.of(Provider.of<AppState>(context, listen: false));

    // Since we manually update [_configuration] when place or selectedCategory
    // changes come from the [place_map], we should only enter this if statement
    // when returning to the [place_map] after changes have been made from
    // [place_list].
    if (_configuration != newConfiguration && mapController != null) {
      if (_configuration.places == newConfiguration.places &&
          _configuration.selectedCategory !=
              newConfiguration.selectedCategory) {
        // If the configuration change is only a category change, just update
        // the marker visibilities.
        await _showPlacesForSelectedCategory(newConfiguration.selectedCategory);
      } else {
        // At this point, we know the places have been updated from the list
        // view. We need to reconfigure the map to respect the updates.
        newConfiguration.places
            .where((p) => !_configuration.places.contains(p))
            .map((value) => _updateExistingPlaceMarker(place: value));

        await _zoomToFitPlaces(
          _getPlacesForCategory(
            newConfiguration.selectedCategory,
            newConfiguration.places,
          ),
        );
      }
      _configuration = newConfiguration;
    }
  }

  void _onPlaceChanged(Place value) {
    // Replace the place with the modified version.
    final newPlaces =
        List<Place>.from(Provider.of<AppState>(context, listen: false).places);
    final index = newPlaces.indexWhere((place) => place.id == value.id);
    newPlaces[index] = value;

    _updateExistingPlaceMarker(place: value);

    // Manually update our map configuration here since our map is already
    // updated with the new marker. Otherwise, the map would be reconfigured
    // in the main build method due to a modified AppState.
    _configuration = MapConfiguration(
      places: newPlaces,
      selectedCategory:
          Provider.of<AppState>(context, listen: false).selectedCategory,
    );

    Provider.of<AppState>(context, listen: false).setPlaces(newPlaces);
  }

  void _pushPlaceDetailsScreen(Place place) {
    assert(place != null);

    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) {
        return PlaceDetails(
          place: place,
          onChanged: (value) => _onPlaceChanged(value),
        );
      }),
    );
  }

  Future<void> _showPlacesForSelectedCategory(PlaceCategory category) async {
    setState(() {
      for (var marker in List.of(_markedPlaces.keys)) {
        final place = _markedPlaces[marker];
        final updatedMarker = marker.copyWith(
          visibleParam: place.category == category,
        );

        _updateMarker(
          marker: marker,
          updatedMarker: updatedMarker,
          place: place,
        );
      }
    });

    await _zoomToFitPlaces(_getPlacesForCategory(
      category,
      _markedPlaces.values.toList(),
    ));
  }

  void _updateExistingPlaceMarker({@required Place place}) {
    var marker = _markedPlaces.keys
        .singleWhere((value) => _markedPlaces[value].id == place.id);

    setState(() {
      final updatedMarker = marker.copyWith(
        infoWindowParam: InfoWindow(
          title: place.name,
          snippet:
              place.starRating != 0 ? '${place.starRating} Star Rating' : null,
        ),
      );
      _updateMarker(marker: marker, updatedMarker: updatedMarker, place: place);
    });
  }

  void _updateMarker({
    @required Marker marker,
    @required Marker updatedMarker,
    @required Place place,
  }) {
    _markers.remove(marker);
    _markedPlaces.remove(marker);

    _markers.add(updatedMarker);
    _markedPlaces[updatedMarker] = place;
  }

  Future<void> _zoomToFitPlaces(List<Place> places) async {
    var controller = await mapController.future;

    // Default min/max values to latitude and longitude of center.
    var minLat = widget.center.latitude;
    var maxLat = widget.center.latitude;
    var minLong = widget.center.longitude;
    var maxLong = widget.center.longitude;

    for (var place in places) {
      minLat = min(minLat, place.latitude);
      maxLat = max(maxLat, place.latitude);
      minLong = min(minLong, place.longitude);
      maxLong = max(maxLong, place.longitude);
    }

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLong),
          northeast: LatLng(maxLat, maxLong),
        ),
        48.0,
      ),
    );
  }

  static Future<BitmapDescriptor> _getPlaceMarkerIcon(
      BuildContext context, PlaceCategory category) async {
    switch (category) {
      case PlaceCategory.favorite:
        return BitmapDescriptor.fromAssetImage(
            createLocalImageConfiguration(context, size: Size.square(32)),
            'assets/heart.png');
        break;
      case PlaceCategory.visited:
        return BitmapDescriptor.fromAssetImage(
            createLocalImageConfiguration(context, size: Size.square(32)),
            'assets/visited.png');
        break;
      case PlaceCategory.wantToGo:
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  static List<Place> _getPlacesForCategory(
      PlaceCategory category, List<Place> places) {
    return places.where((place) => place.category == category).toList();
  }
}
