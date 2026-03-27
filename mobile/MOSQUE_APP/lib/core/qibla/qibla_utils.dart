import 'dart:math';
import 'package:vector_math/vector_math.dart' as vmath;

class QiblaUtils {
  static const double kaabaLat = 21.4225;
  static const double kaabaLng = 39.8262;

  static double calculateQiblaDirection(
      double userLat, double userLng) {
    final lat1 = vmath.radians(userLat);
    final lon1 = vmath.radians(userLng);
    final lat2 = vmath.radians(kaabaLat);
    final lon2 = vmath.radians(kaabaLng);

    final dLon = lon2 - lon1;

    final y = sin(dLon);
    final x =
        cos(lat1) * tan(lat2) - sin(lat1) * cos(dLon);

    final bearing = atan2(y, x);
    return (vmath.degrees(bearing) + 360) % 360;
  }
}
