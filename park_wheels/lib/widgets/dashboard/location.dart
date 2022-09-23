import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:park_wheels/utils/style.dart';

class LocationSelector extends StatelessWidget {
  final Function onTap;
  final GeoPoint? point;

  const LocationSelector({Key? key, required this.onTap, this.point})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: size.width / 2.4,
        decoration: BoxDecoration(
            color: Style.primary, borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            const Icon(
              Icons.location_pin,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            point == null
                ? locationText('unknown')
                : FutureBuilder<Placemark>(
                    future: placemarkFromCoordinates(
                            point?.latitude ?? 0, point?.longitude ?? 0)
                        .then((value) => value.first),
                    builder: (_, snap) => locationText(
                        snap.hasData ? "${snap.data?.locality}" : "unknown")),
          ],
        ),
      ),
    );
  }

  Widget locationText(String text) => Expanded(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      );
}
