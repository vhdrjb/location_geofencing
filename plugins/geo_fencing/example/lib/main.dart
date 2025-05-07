import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geo_fencing/geo_fencing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future? _dataFuture;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _init() async {
    GeoFencing geoFencing = GeoFencing();
    try {
      await geoFencing.init();
      return true;
    } catch (_) {
      return false;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<bool>(
                  future: _init(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return LocationInfoWidget();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationInfoWidget extends StatefulWidget {
  const LocationInfoWidget({super.key});

  @override
  State<LocationInfoWidget> createState() => _LocationInfoWidgetState();
}

class _LocationInfoWidgetState extends State<LocationInfoWidget> {
  Future<Iterable<Location>>? _locations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await GeoFencing().insert(
              Location(
                name: 'Location new',
                latitude: 20.12345678,
                longitude: 60.87654321,
              ),
            );
            setState(() {
              _locations = GeoRepository().locationDao.getAll();
            });
          },
          child: Text('add location'),
        ),
        Expanded(
          child: FutureBuilder(
            future: _locations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<Location> locations = snapshot.data!.toList();
                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(locations[index].name),
                      subtitle: Text(
                        '${locations[index].latitude}:${locations[index].longitude}',
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
