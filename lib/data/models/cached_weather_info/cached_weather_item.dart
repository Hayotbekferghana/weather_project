const String weatherTable = "weather_table";

class CachedWeatherItemFields {
  static final List<String> values = [
    /// Add all fields
    id, temperature, addressName, weatherType,
  ];
  static const String id = "_id";
  static const String temperature = "temperature";
  static const String addressName = "address_name";
  static const String weatherType = "weather_type";

  static fromJson(Map<String, dynamic> data) {}
}

class CachedWeatherItem {
  final int? id;
  final String temperature;
  final String addressName;
  final String weatherType;

  CachedWeatherItem({
    this.id,
    required this.addressName,
    required this.weatherType,
    required this.temperature,
  });

  CachedWeatherItem copyWith({
    int? id,
    String? addressName,
    String? weatherType,
    String? temperature,
  }) =>
      CachedWeatherItem(
        id: id ?? this.id,
        addressName: addressName ?? this.addressName,
        weatherType: weatherType ?? this.weatherType,
        temperature: temperature ?? this.temperature,
      );

  static CachedWeatherItem fromJson(Map<String, Object?> json) =>
      CachedWeatherItem(
        id: json[CachedWeatherItemFields.id] as int?,
        temperature: json[CachedWeatherItemFields.temperature] as String,
        addressName: json[CachedWeatherItemFields.addressName] as String,
        weatherType: json[CachedWeatherItemFields.weatherType] as String,
      );

  Map<String, Object?> toJson() => {
        CachedWeatherItemFields.id: id,
        CachedWeatherItemFields.addressName: addressName,
        CachedWeatherItemFields.temperature: temperature,
        CachedWeatherItemFields.weatherType: weatherType,
      };

  @override
  String toString() => '''
        id: $id 
        temperature $temperature
        addressName $addressName
        weatherType $weatherType
      ''';
}
