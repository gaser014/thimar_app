import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themar/core/logic/get_it.dart';
import 'package:themar/features/location/bloc.dart';

class AppMap extends StatefulWidget {
  AppMap({
    super.key,
  });

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  late final LocationBloc bloc;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    bloc = getIt<LocationBloc>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: .4.sh,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            const Color(0xffc9c9c9).withOpacity(0.2),
            BlendMode.hue,
          ),
          child: GoogleMap(
            padding: EdgeInsets.only(left: 2.sw),

            zoomControlsEnabled: false,
            //change bland mode
            mapType: MapType.terrain,
            markers: {bloc.marker},

            initialCameraPosition: CameraPosition(
              target: bloc.marker.position,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng latLng) {
              setState(() {
                bloc.marker = Marker(
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                    markerId: const MarkerId('1'),
                    position: latLng);
              });
            },
          ),
        ),
      ),
    );
  }
}
