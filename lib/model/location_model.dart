class LocationModel {
  String locationId;
  String? locationName;
  String? streetName;
  String? rtNumber;
  String? rwNumber;
  String? streetNumber;
  String? kecamatan;
  String? kabupatenOrKota;
  String? userId;

  LocationModel({
    required this.locationId,
    this.locationName,
    this.streetName,
    this.rtNumber,
    this.rwNumber,
    this.streetNumber,
    this.kecamatan,
    this.kabupatenOrKota,
    this.userId,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      locationId: map['location_id'] as String,
      locationName: map['location_name'] as String?,
      streetName: map['street_name'] as String?,
      rtNumber: map['rt_number'] as String?,
      rwNumber: map['rw_number'] as String?,
      streetNumber: map['street_number'] as String?,
      kecamatan: map['kecamatan'] as String?,
      kabupatenOrKota: map['kabupaten_or_kota'] as String?,
      userId: map['user_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location_id': locationId,
      'location_name': locationName,
      'street_name': streetName,
      'rt_number': rtNumber,
      'rw_number': rwNumber,
      'street_number': streetNumber,
      'kecamatan': kecamatan,
      'kabupaten_or_kota': kabupatenOrKota,
      'user_id': userId,
    };
  }
}
