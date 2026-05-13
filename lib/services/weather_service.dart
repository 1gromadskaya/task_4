import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_service.g.dart';

@JsonSerializable()
class WeatherResponse {
  final MainData main;
  final List<WeatherData> weather;

  WeatherResponse({required this.main, required this.weather});
  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
}

@JsonSerializable()
class MainData {
  final double temp;
  MainData({required this.temp});
  factory MainData.fromJson(Map<String, dynamic> json) => _$MainDataFromJson(json);
}

@JsonSerializable()
class WeatherData {
  final String description;
  WeatherData({required this.description});
  factory WeatherData.fromJson(Map<String, dynamic> json) => _$WeatherDataFromJson(json);
}

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5")
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET("/weather")
  Future<WeatherResponse> getWeather(
      @Query("lat") double lat,
      @Query("lon") double lon,
      @Query("appid") String appId,
      @Query("units") String units,
      @Query("lang") String lang,
      );
}

class WeatherService {
  static const String apiKey = 'bd5e378503939ddaee76f12ad7a97608';
  final WeatherApiClient _client;

  WeatherService() : _client = WeatherApiClient(Dio());

  Future<String> getWeatherString(double lat, double lon) async {
    try {
      final response = await _client.getWeather(lat, lon, apiKey, 'metric', 'ru');
      return '${response.main.temp.round()}°C, ${response.weather.first.description}';
    } catch (e) {
      return 'Ошибка сети/данных';
    }
  }
}