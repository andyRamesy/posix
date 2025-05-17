import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:posix/core/configs/constants/api_url.dart';
import 'package:posix/presentation/home/bloc/user_location_cubit.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocationCubit, UserLocationState>(
        builder: (context, state) {
      if (state is UserLocationLoading) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is UserLocationOnFailure) {
        return const Center(
          child: Text('Get user location failed'),
        );
      } else if (state is UserLocationOnSuccess) {
        final userLocation = state.userLocation;
        return FlutterMap(
            options: MapOptions(
                initialCenter:
                    LatLng(userLocation.latitude, userLocation.longitude),
                initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate: ApiUrl.tileLayerUrl,
                userAgentPackageName: 'com.example.posix',
              ),
              MarkerLayer(markers: [
                Marker(
                  child: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.red,
                  ),
                  point: LatLng(userLocation.latitude, userLocation.longitude),
                )
              ])
            ]);
      }
      return SizedBox.shrink();
    });
  }
}
