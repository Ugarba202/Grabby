import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/core/constant/app_string.dart';
import 'package:grabby_app/screens/onboaring/widgets/primary_bottom.dart';
import 'package:grabby_app/screens/onboaring/widgets/text_button_link.dart';
import 'package:grabby_app/core/utils/location_helper.dart';
import 'package:grabby_app/services/user_service.dart';
import 'package:provider/provider.dart';

class EnableLocationScreen extends StatefulWidget {
  const EnableLocationScreen({super.key});

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  // ✅ Use Completer instead of nullable controller (best practice)
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? currentPosition;
  // ✅ Default to a central point in Nigeria
  LatLng _selectedPosition = const LatLng(9.0820, 8.6753);
  bool _isLoading = true;
  final Set<Marker> _markers = {};

  // To get address from coordinates, you can use a package like 'geocoding'.
  String _currentAddress = "Searching for location...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // ✅ Fetch and update user location safely
  // This will now only run once to get the initial position.
  Future<void> _getLocation() async {
    final hasPermission = await LocationHelper.requestPermission();
    if (!hasPermission) {
      setState(() => _isLoading = false);
      return;
    }

    final position = await LocationHelper.getCurrentLocation();
    if (position != null) {
      setState(() {
        _selectedPosition = LatLng(position.latitude, position.longitude);
        currentPosition = _selectedPosition;
        _isLoading = false;
        _addMarker(_selectedPosition);
        _currentAddress = "Your Current Location";
      });

      // ✅ Move camera smoothly to current position if map is ready
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedPosition, 15),
      );
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Set Your Location'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Stack(
        children: [
          // 🗺️ Google Map View
          GoogleMap(
            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            initialCameraPosition: CameraPosition(
              target: const LatLng(9.0820, 8.6753), // Center of Nigeria
              zoom: 6.5, // Zoom level to show the whole country
            ),
            markers: _markers,
            // ✅ Restrict map boundaries to Nigeria
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: const LatLng(4.276, 2.697), // SW corner of Nigeria
                northeast: const LatLng(13.883, 14.678), // NE corner of Nigeria
              ),
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onCameraMove: (position) {
              // When the user pans the map, the new center becomes the selected location
              _selectedPosition = position.target;
            },
            onCameraIdle: () {
              // When the user stops panning, update the marker
              setState(() {
                _addMarker(_selectedPosition);
                // Here you could use a geocoding service to get the address
                // for the _selectedPosition and update _currentAddress.
              });
            },
          ),

          // Center Marker Icon
          if (!_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 40.0,
                ), // Adjust to center icon correctly
                child: Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            ),

          // ⬆️ Bottom Card Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isLoading) const CircularProgressIndicator(),
                  const Text(
                    AppStrings.geoText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // You can display the address here
                  Text(
                    _isLoading ? "Fetching location..." : _currentAddress,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButtonLink(
                          text: "Skip ",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes
                                  .main_screen, // Navigate to main screen on skip
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          text: "Confirm Location",
                          onPressed: () async {
                            // Save the selected location to the user's profile
                            final userService = context.read<UserService>();
                            await userService.updateUserProfile({
                              'location': GeoPoint(
                                _selectedPosition.latitude,
                                _selectedPosition.longitude,
                              ),
                            });

                            debugPrint(
                              'Selected Location: ${_selectedPosition.latitude}, ${_selectedPosition.longitude}',
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.main_screen,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng position) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('selectedLocation'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ),
    );
  }
}
