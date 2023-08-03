import 'package:flutter_map/flutter_map.dart';
import 'package:onyx/core/extensions/coords_to_num.dart';
import 'package:onyx/core/extensions/lat_lng_inside.dart';
import 'package:onyx/screens/map/map_export.dart';

class HybridTileProvider extends TileProvider {
  AssetTileProvider? _offlineTileProvider;
  NetworkTileProvider? _onlineTileProvider; //NetworkNoRetryTileProvider

  HybridTileProvider() {
    _offlineTileProvider = AssetTileProvider();
    _onlineTileProvider = NetworkTileProvider();
  }

  @override
  getImage(TileCoordinates coordinates, TileLayer options) {
    if (coordinates.toDeg().inside(MapRes.minBound, MapRes.maxBound) &&
        coordinates.z > MapRes.minZoom &&
        coordinates.z < MapRes.maxZoom) {
      options = TileLayer(
        urlTemplate: "assets/map/{z}/{x}/{y}.png",
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        tileProvider: _offlineTileProvider,
      );
      return _offlineTileProvider!.getImage(coordinates, options);
    } else {
      options = TileLayer(
        urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
        tileProvider: _onlineTileProvider,
      );
      return _onlineTileProvider!.getImage(coordinates, options);
    }
  }
}

// TileLayer(
// urlTemplate: "assets/map/{z}/{x}/{y}.png",
// userAgentPackageName: 'dev.fleaflet.flutter_map.example',
// tileProvider: AssetTileProvider(),
// ),
