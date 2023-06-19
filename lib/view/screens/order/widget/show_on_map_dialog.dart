import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';

class ShowOnMapDialog extends StatelessWidget {
  const ShowOnMapDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return  Dialog(
      child: SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child: const GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(23.837472, 90.369573),
              zoom: 15,
            ),

            zoomControlsEnabled: false,
            compassEnabled: false,
            indoorViewEnabled: true,
            mapToolbarEnabled: false,
          ),
        ),
      ),
    );
  }
}
