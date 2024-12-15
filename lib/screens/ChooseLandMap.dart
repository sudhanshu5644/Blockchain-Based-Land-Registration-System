// ignore_for_file: avoid_web_libraries_in_flutter, file_names, camel_case_types

import 'dart:html';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:mapbox_search/mapbox_search.dart';

class landOnMap extends StatefulWidget {
  const landOnMap({Key? key}) : super(key: key);

  @override
  _landOnMapState createState() => _landOnMapState();
}

class _landOnMapState extends State<landOnMap> {
  late MapboxMapController mapController;
  List<LatLng> polygon = [];
  late Fill landPolygonFill;
  bool _polygonAdded = false;
  bool isSatelliteView = true;
  String allLatitude = "", allLongitude = "";
  TextEditingController addressController = TextEditingController();
  LatLng initialPos = const LatLng(17.4838891, 75.2999884);
  List<MapBoxPlace> predictions = [];
  late PlacesSearch placesSearch;
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 600,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0.0, 40 + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: List.generate(
                        predictions.length,
                        (index) => ListTile(
                              title:
                                  Text(predictions[index].placeName.toString()),
                              onTap: () {
                                addressController.text =
                                    predictions[index].placeName.toString();
                                initialPos = LatLng(
                                    predictions[index]
                                        .geometry!
                                        .coordinates![1],
                                    predictions[index]
                                        .geometry!
                                        .coordinates![0]);

                                mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                  zoom: 15.0,
                                  target: initialPos,
                                )));
                                setState(() {});
                                _overlayEntry.remove();
                                _overlayEntry.dispose();
                              },
                            )),
                  ),
                ),
              ),
            ));
  }

  Future<void> autocomplete(value) async {
    List<MapBoxPlace>? res = await placesSearch.getPlaces(value);
    if (res != null) predictions = res;
    setState(() {});
    // print(res);
    // print(res![0].placeName);
    // print(res![0].geometry!.coordinates);
    // print(res![0]);
  }

  @override
  void initState() {
    placesSearch = PlacesSearch(
      apiKey: mapBoxApiKey,
      limit: 10,
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 185, 44),
        title: const Text('Mark Land on Map'),
        actions: [
          Center(
            child: Container(
              width: 400,
              decoration: const BoxDecoration(color: Colors.white),
              child: CompositedTransformTarget(
                link: _layerLink,
                child: TextField(
                  controller: addressController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      autocomplete(value);
                      _overlayEntry.remove();
                      _overlayEntry = _createOverlayEntry();
                      Overlay.of(context).insert(_overlayEntry);
                    } else {
                      if (predictions.isNotEmpty && mounted) {
                        setState(() {
                          predictions = [];
                        });
                      }
                    }
                  },
                  focusNode: _focusNode,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 185, 44))),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // const SizedBox(
              //   // height: ,
              // ),
              Container(
                height: 500,
                width: 900,
                child: MapboxMap(
                    accessToken: mapBoxApiKey,
                    styleString: isSatelliteView
                        ? "mapbox://styles/mapbox/satellite-streets-v12"
                        : "mapbox://styles/mapbox/outdoors-v12",
                    initialCameraPosition: const CameraPosition(
                      zoom: 3.0,
                      // target: LatLng(19.663280, 75.300293),
                      target: LatLng(22, 78),
                    ),
                    onMapCreated: (MapboxMapController controller) {
                      mapController = controller;
                    },
                    compassEnabled: false,
                    onMapClick:
                        (Point<double> point, LatLng coordinates) async {
                      if (_polygonAdded) {
                        polygon.add(coordinates);
                        allLatitude += coordinates.latitude.toString() + ",";
                        allLongitude += coordinates.longitude.toString() + ",";

                        mapController.addCircle(CircleOptions(
                            geometry: coordinates,
                            circleRadius: 5,
                            circleColor: "#ff0000",
                            draggable: true));

                        if (polygon.length == 3) {
                          landPolygonFill = await mapController.addFill(
                            FillOptions(
                              fillColor: "#2596be",
                              fillOutlineColor: "#2596be",
                              geometry: [polygon],
                            ),
                          );
                        }
                        if (polygon.length > 3) {
                          mapController.updateFill(
                              landPolygonFill,
                              FillOptions(
                                fillColor: "#2596be",
                                fillOutlineColor: "#2596be",
                                geometry: [polygon],
                              ));

                          //print(landPolygonFill.options.geometry.toString());
                        }
                      }
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: _polygonAdded
                        ? const Text('Drawing')
                        : const Text('Start Drawing'),
                    onPressed: () {
                      _polygonAdded = true;
                      showToast("Add one by one marker on map",
                          context: context,
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3));
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear All'),
                    onPressed: () {
                      mapController.clearCircles();
                      mapController.clearFills();
                      polygon = [];
                      allLatitude = "";
                      allLongitude = "";
                      setState(() => _polygonAdded = false);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    onPressed: () {
                      allLatitude = allLatitude.trim();
                      allLatitude =
                          allLatitude.substring(0, allLatitude.length - 1);
                      allLongitude = allLongitude.trim();
                      allLongitude =
                          allLongitude.substring(0, allLongitude.length - 1);
                      allLatitude = allLatitude + "|" + allLongitude;
                      Navigator.pop(context, allLatitude);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.change_circle),
                    label: !isSatelliteView
                        ? const Text('Satellite View')
                        : const Text('Road Map View'),
                    onPressed: () {
                      isSatelliteView = !isSatelliteView;
                      setState(() {});
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
