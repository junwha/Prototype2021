import 'package:prototype2021/model/google_place/place_data.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';

class GooglePlaceLocation extends Location {
  late final String placeId;
  String? description;
  late String preview;

  GooglePlaceLocation(this.placeId, String? preview, String name,
      this.description, latLng, String type)
      : super(latLng, type, name) {
    this.preview = preview ?? placeHolder;
  }

  GooglePlaceLocation.fromData(GooglePlaceData placeData)
      : super(placeData.location, placeData.type, placeData.name) {
    this.placeId = placeData.placeId;
    this.preview = placeData.photo ?? placeHolder;
    this.description = placeData.address;
  }
}
