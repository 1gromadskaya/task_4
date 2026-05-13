import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/library_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  LatLng? _selectedLocation;
  String? _selectedLibraryName;

  final LatLng _minskCenter = const LatLng(53.9045, 27.5615);

  final List<Map<String, dynamic>> _cityLibraries = [
    {'name': 'Национальная библиотека', 'lat': 53.9314, 'lon': 27.6461},
    {'name': 'Библиотека им. Янки Купалы', 'lat': 53.9197, 'lon': 27.5794},
    {'name': 'Президентская библиотека', 'lat': 53.8967, 'lon': 27.5482},
    {'name': 'Библиотека им. А.С. Пушкина', 'lat': 53.9110, 'lon': 27.5898},
    {'name': 'Детская библиотека №4', 'lat': 53.8926, 'lon': 27.5441},
    {'name': 'Научная библиотека БНТУ', 'lat': 53.9216, 'lon': 27.5921},
    {'name': 'Библиотека им. Л.Н. Толстого', 'lat': 53.8861, 'lon': 27.5381},
  ];

  void _saveLibrary() {
    if (_selectedLibraryName != null && _selectedLocation != null) {
      ref.read(libraryProvider.notifier).addLibrary(
        _selectedLibraryName!,
        "Координаты: ${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)}",
        lat: _selectedLocation!.latitude,
        lon: _selectedLocation!.longitude,
      );

      setState(() {
        _selectedLocation = null;
        _selectedLibraryName = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Библиотека добавлена в ваш список!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = _cityLibraries.map((lib) {
      final latLng = LatLng(lib['lat'], lib['lon']);

      final isSelected = _selectedLocation == latLng;

      return Marker(
        point: latLng,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedLocation = latLng;
              _selectedLibraryName = lib['name'];
            });
          },
          child: Icon(
            Icons.location_on,
            color: isSelected ? Colors.red : Colors.blue,
            size: isSelected ? 55 : 40,
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Справочник библиотек'),
        backgroundColor: Colors.green.withValues(alpha: 0.8),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _minskCenter,
              initialZoom: 12,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = null;
                  _selectedLibraryName = null;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.task_4',
              ),
              MarkerLayer(markers: markers),
            ],
          ),

          if (_selectedLibraryName != null)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedLibraryName!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _saveLibrary,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Добавить в мой список', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}