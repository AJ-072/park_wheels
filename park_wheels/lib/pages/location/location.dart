import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:park_wheels/widgets/dashboard/location.dart';
import 'package:sizer/sizer.dart';

class SetLocation extends StatefulWidget {
  GeoPoint? geoPoint;

  SetLocation({Key? key, this.geoPoint}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SetLocationState();
}

// class Controller extends MapController {}

class SetLocationState extends State<SetLocation> {
  GeoPoint? point;
  GlobalKey markerKey = GlobalKey();
  ValueNotifier<GeoPoint> pointNotifier =
      ValueNotifier(GeoPoint(latitude: 0, longitude: 0));

  late MapController controller;

  SetLocationState({this.point}) {
    controller = MapController(initPosition: point ?? pointNotifier.value);
  }

  Future<void> setPoint() async => await controller
      .getCurrentPositionAdvancedPositionPicker()
      .then((value) => pointNotifier.value = value);

  @override
  void initState() {
    controller.init();
    // controller.advancedPositionPicker();
    super.initState();
  }

  @override
  void dispose() {
    controller.cancelAdvancedPositionPicker();
    // controller.listenerRegionIsChanging.removeListener(() { })
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setPoint();
    });

    // controller.listenerRegionIsChanging.addListener(() => setPoint());
    // controller.listenerMapSingleTapping.addListener(() {print("single tap");});
    // controller.listenerMapLongTapping.addListener(() {print("lon tap");});
    // showSimplePickerLocation(
    //   context: context,
    //   isDismissible: true,
    //   title: "Title dialog",
    //   textConfirmPicker: "pick",
    //   initCurrentUserPosition: true,
    // ).then((value) => print("lat ${value?.latitude} long ${value?.longitude}"));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          OSMFlutter(
            initZoom: 12,
            mapIsLoading: Center(child: CircularProgressIndicator()),
            controller: controller,
            androidHotReloadSupport: true,
            isPicker: true,
          ),
          Center(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 24,
            ),
          ),
        ],
      )),
      bottomSheet: BottomSheet(
        elevation: 10,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<GeoPoint>(
                    valueListenable: pointNotifier,
                    builder: (context, value, _) => LocationSelector(
                          onTap: () {},
                          point: value,
                        )),
                Container(
                  width: 100.w,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, point);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      elevation: MaterialStateProperty.all(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Next >>",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        enableDrag: false,
        onClosing: () {},
      ),
    );
  }
}
