import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovlah_driver/Models/models.dart';

class MapRoute extends StatefulWidget {
  OrdersModel order;
  MapRoute({super.key, required this.order});

  @override
  State<MapRoute> createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  LatLng? _initialPosition;
  bool loading = false;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Map<PolylineId, Polyline> polylines = {};
  String googleAPIKey = "AIzaSyDC8eK2_tywqgCtS8kLaOdrjs61aMVP1hI";
  TravelMode travelModeOption = TravelMode.driving;
  PolylinePoints? polylinePoints;
  List<LatLng> polylineCoordinates = [];
  double distance = 0;
  List<PolylineWayPoint> wayPoints = [];
  Map<MarkerId, Marker> loungeMarkers = <MarkerId, Marker>{};
  int polyColor = 0;
  @override
  void initState() {
    super.initState();
    createMarker();
    pointSetter();
    generatePolyline();
    _getUserLocation();
  }

  pointSetter() {
    int j = 0;
    for (int i = 0;
        i <
            widget.order.ordersModelLocationSub.locationListlocationLat.length -
                1;
        i++) {
      if (i != 0 &&
          i !=
              widget.order.ordersModelLocationSub.locationListlocationLat
                      .length -
                  1) {
        wayPoints.add(PolylineWayPoint(
            location: widget.order.ordersModelLocationSub.locationListName[i]));
        j++;
      }
    }
  }

  _addPolyLine() {
    List<LatLng> polylineCoordinate = [];
    for (int i = 0; i < polylineCoordinates.length - 2; i++) {
      polylineCoordinate.add(polylineCoordinates[i]);
    }

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.black, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  createMarker() {
    for (int i = 0;
        i < widget.order.ordersModelLocationSub.locationListlocationLat.length;
        i++) {
      String markerIdVal1 =
          widget.order.ordersModelLocationSub.locationListdescription[i] +
              i.toString();
      final Marker marker = Marker(
        markerId: MarkerId(markerIdVal1.toString()),
        position: LatLng(
            widget.order.ordersModelLocationSub.locationListlocationLat[i] ?? 0,
            widget.order.ordersModelLocationSub.locationListlocationLong[i] ??
                0),
        icon: BitmapDescriptor.defaultMarkerWithHue(10),
      );
      setState(() {
        // adding a new marker to map

        loungeMarkers[MarkerId(markerIdVal1.toString() + i.toString())] =
            marker;
      });
    }
  }

  generatePolyline() {
    for (int i = 0;
        i <
            widget.order.ordersModelLocationSub.locationListdescription.length -
                1;
        i++) {
      createPolylines(
        widget.order.ordersModelLocationSub.locationListlocationLat[i],
        widget.order.ordersModelLocationSub.locationListlocationLong[i],
        widget.order.ordersModelLocationSub.locationListlocationLat[i + 1],
        widget.order.ordersModelLocationSub.locationListlocationLong[i + 1],
      );
    }
    _addPolyLine();
  }

  createPolylines(lat1, lon1, lat2, lon2) async {
    polyColor++;
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      googleAPIKey, // Google Maps API Key
      PointLatLng(lat1, lon1),
      PointLatLng(lat2, lon2),
      // wayPoints: wayPoints,
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    

    // for (int i = 0; i < polylineCoordinates.length - 1; i++) {
    //   distance = distance +
    //       calculateDistance(
    //           polylineCoordinates[i].latitude,
    //           polylineCoordinates[i].longitude,
    //           polylineCoordinates[i + 1].latitude,
    //           polylineCoordinates[i + 1].longitude);
    // }
    return distance;
  }

  void _getUserLocation() async {
    setState(() {
      loading = true;
    });
    var _locationData;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _locationData = await Geolocator.getCurrentPosition();
    _initialPosition =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('markers: ' + loungeMarkers.length.toString());
    return Scaffold(
      body: widget.order.ordersModelLocationSub.locationListlocationLong ==
                  null ||
              widget.order.ordersModelLocationSub.locationListlocationLong
                      .length ==
                  0
          //  loading == true
          ? const Center(
              child: SpinKitCircle(
                color: Colors.black,
                size: 50.0,
              ),
            )
          : GoogleMap(
              // markers: Set<Marker>.of(markers.values),
              mapType: MapType.normal,
              tiltGesturesEnabled: false,
              markers: Set<Marker>.of(loungeMarkers.values),
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              initialCameraPosition: CameraPosition(
                tilt: 0,
                bearing: 0,
                target: LatLng(
                    widget.order.ordersModelLocationSub
                        .locationListlocationLat[0],
                    widget.order.ordersModelLocationSub
                        .locationListlocationLong[0]),
                zoom: 17.00,
              ),
              // onTap: _handleTap,
              // onCameraMove: _onCameraMove,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
