import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:flutter_complete_guide/models/place.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    _items.firstWhere((great_place) => great_place.id == id);
  }

  void addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updateLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            image: File(place['image']),
            location: PlaceLocation(
              latitude: place['loc_lat'],
              longitude: place['loc_lng'],
              address: place['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
