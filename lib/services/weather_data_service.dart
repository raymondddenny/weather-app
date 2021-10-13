import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherDataService {
  Future<WeatherModel> getWeatherData({required String cityName}) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    const apiKey = "YOUR OPEN WEATHER API KEY HERE";

    final queryParameters = {'q': cityName, 'appid': apiKey, 'units': 'metric'};

    final uri = Uri.https(
        "api.openweathermap.org", "/data/2.5/weather", queryParameters);

    final response = await http.get(uri);

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      final jsonData = jsonDecode(response.body);
      return WeatherModel.fromJsonError(jsonData);
    }
  }
}
