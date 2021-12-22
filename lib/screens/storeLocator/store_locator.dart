import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreLocator extends StatefulWidget {
  const StoreLocator({Key? key}) : super(key: key);

  @override
  _StoreLocatorState createState() => _StoreLocatorState();
}

class _StoreLocatorState extends State<StoreLocator> {
  late GoogleMapController controller;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(19.059984, 72.889999), zoom: 12);

  List<Marker> markers = [
    Marker(markerId: MarkerId('id1'), position: LatLng(19.0596, 72.8295)),
    Marker(markerId: MarkerId('id2'), position: LatLng(19.1663, 72.8526)),
    Marker(markerId: MarkerId('id3'), position: LatLng(19.1726, 72.9425)),
    Marker(markerId: MarkerId('id4'), position: LatLng(19.1136, 72.8697)),
    Marker(markerId: MarkerId('id5'), position: LatLng(19.0522, 72.9005)),
  ];

  Set<Marker> _marker = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _marker.addAll(markers);
      // print(_marker);
    });
  }

  List<String> store_names = [
    'SKYLAND STORE',
    'WOODMOUNT STORE',
    'NATUFUR STORE',
    'LAVANDER STORE',
    'FURNIMATT STORE'
  ];

  List<String> addr = [
    '6335 Edgewood Road Reisterstowm, MD 21136',
    '9437 Pin Oak Drive South Plainfield, NJ 07080',
    '3789 Pennysylvania Avenue Brandon, FL 33510',
    '9311 Garfield Avenue Hamburg, NY 14075',
    '7346 Hanover Court Arlington, MA 02474'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Store Locator',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            // width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: _onMapCreated,
              markers: _marker,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  MdiIcons.mapMarkerAlert,
                  color: AppColors.PRIMARY_COLOR_BLACK1,
                  size: 30,
                ),
                title: Text(
                  store_names[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.PRIMARY_COLOR_BLACK1,
                  ),
                ),
                subtitle: Text(
                  addr[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: AppColors.PRIMARY_COLOR_BLACK4),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.PRIMARY_COLOR_GREY4,
            ),
          ),
          const Divider(
            color: AppColors.PRIMARY_COLOR_GREY4,
          ),
        ],
      ),
    );
  }
}
