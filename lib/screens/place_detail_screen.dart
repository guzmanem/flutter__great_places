import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
    );
  }
}
