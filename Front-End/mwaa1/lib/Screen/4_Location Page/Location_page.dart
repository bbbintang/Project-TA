import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  final bool isFromButton;
  const LocationPage({super.key, required this.isFromButton});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? visibleText;
  LatLng? userLocation;
  bool isLocationLoaded = false;

  final LatLng alat1Location = LatLng(-6.969103, 107.628248);
  final LatLng alat2Location = LatLng(-6.969105, 107.628249);

  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Layanan lokasi tidak diaktifkan")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Izin lokasi ditolak")));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Izin lokasi ditolak secara permanen")));
      return;
    }

    Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      isLocationLoaded = true;
    });
  }

  void _refreshLocation() async {
    setState(() {
      userLocation = null;
      _getUserLocation();
    });
    await _getUserLocation();

  if (userLocation != null) {
    mapController.move(userLocation!, 15.0);
    mapController.rotate(0);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Image.asset(
          "assets/LOGOaja.png",
          color: Colors.white,
          height: 100,
          width: 100,
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        elevation: 1.0,
        automaticallyImplyLeading: widget.isFromButton,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: userLocation ?? alat1Location,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: alat1Location,
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => visibleText = "Alat 1"),
                      onTapUp: (_) => setState(() => visibleText = null),
                      onTapCancel: () => setState(() => visibleText = null),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (visibleText == "Alat 1")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                visibleText!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(height: 10),
                          Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ],
                      ),
                    ),
                  ),
                  Marker(
                    point: alat2Location,
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => visibleText = "Alat 2"),
                      onTapUp: (_) => setState(() => visibleText = null),
                      onTapCancel: () => setState(() => visibleText = null),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (visibleText == "Alat 2")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                visibleText!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(height: 10),
                          Icon(Icons.location_pin, color: Colors.blue, size: 40),
                        ],
                      ),
                    ),
                  ),
                  if (userLocation != null)
                    Marker(
                      point: userLocation!,
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      child: Icon(Icons.my_location, color: Colors.cyan, size: 40),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _refreshLocation,
              backgroundColor: const Color.fromARGB(255, 254, 186, 84).withOpacity(0.85),
              elevation: 5,
              child: Icon(Icons.refresh, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
