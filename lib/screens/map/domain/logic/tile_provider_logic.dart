import 'package:flutter_map/flutter_map.dart';
import 'package:onyx/core/extensions/coords_to_num.dart';
import 'package:onyx/core/extensions/lat_lng_inside.dart';
import 'package:onyx/screens/map/map_export.dart';

class HybridTileProvider extends TileProvider {
  AssetTileProvider? _offlineTileProvider;
  NetworkNoRetryTileProvider? _onlineTileProvider;

  HybridTileProvider() {
    _offlineTileProvider = AssetTileProvider();
    _onlineTileProvider = NetworkNoRetryTileProvider();
  }

  @override
  getImage(Coords<num> coords, TileLayer options) {
    if (coords.toDeg().inside(MapRes.minBound, MapRes.maxBound) &&
        coords.z > MapRes.minZoom &&
        coords.z < MapRes.maxZoom) {
      options = TileLayer(
        urlTemplate: "assets/map/{z}/{x}/{y}.png",
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        tileProvider: _offlineTileProvider,
      );
      return _offlineTileProvider!.getImage(coords, options);
    } else {
      options = TileLayer(
        urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
        tileProvider: _onlineTileProvider,
      );
      return _onlineTileProvider!.getImage(coords, options);
    }
  }
}

// TileLayer(
// urlTemplate: "assets/map/{z}/{x}/{y}.png",
// userAgentPackageName: 'dev.fleaflet.flutter_map.example',
// tileProvider: AssetTileProvider(),
// ),
