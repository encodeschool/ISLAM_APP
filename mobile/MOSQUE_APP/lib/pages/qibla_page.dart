import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import '../core/qibla/qibla_utils.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  double? _qiblaDirection;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final qibla = QiblaUtils.calculateQiblaDirection(
        _position!.latitude,
        _position!.longitude,
      );

      setState(() {
        _qiblaDirection = qibla;
      });
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_qiblaDirection == null || _position == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.heading == null) {
          return const Center(
            child: Text("Compass not available on this device"),
          );
        }

        final heading = snapshot.data!.heading!;

        final compassRotation =
            (heading - _qiblaDirection!) * (pi / 180);

        return Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: compassRotation,
                child: Image.asset(
                  'assets/images/compass_bg.png',
                  width: 300,
                  height: 300,
                ),
              ),

              Positioned(
                top: -50,
                child: Column(
                  children: [
                    // Needle
                    Container(
                      width: 6,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }
