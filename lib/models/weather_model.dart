/* 

{
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "humidity": 100
  },
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "name": "Mountain View",
  } 
*/

class WeatherModel {
  final String? cityName;
  final TemperaturInfo? temperaturInfo;
  final WeatherInfo? weatherInfo;
  final WindInfo? windInfo;
  final String? code;
  final String? message;

  WeatherModel(
      {this.cityName,
      this.temperaturInfo,
      this.weatherInfo,
      this.windInfo,
      this.code,
      this.message});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final tempInfoJson = json['main'];
    final weatherInfoJson = json['weather'][0];
    final windInfoJson = json['wind'];
    final temperaturInfo = TemperaturInfo.fromJson(tempInfoJson);
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    final windInfo = WindInfo.fromJson(windInfoJson);
    return WeatherModel(
        cityName: cityName,
        temperaturInfo: temperaturInfo,
        weatherInfo: weatherInfo,
        windInfo: windInfo);
  }

  // error return
  factory WeatherModel.fromJsonError(Map<String, dynamic> json) {
    final code = json['cod'];
    final message = json['message'];
    return WeatherModel(
      code: code,
      message: message,
    );
  }
}

class TemperaturInfo {
  final double? tempInfo;
  final int? humidity;
  final double? feelsLike;
  TemperaturInfo({this.tempInfo, this.humidity, this.feelsLike});

  factory TemperaturInfo.fromJson(Map<String, dynamic> json) {
    final tempInfo = json['temp'];
    final feelsLike = json['feels_like'];
    final humidity = json['humidity'];
    return TemperaturInfo(
        tempInfo: tempInfo, humidity: humidity, feelsLike: feelsLike);
  }
}

class WeatherInfo {
  final String? description;
  final String? icon;
  WeatherInfo({this.description, this.icon});

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class WindInfo {
  final double? speed;
  final int? deg;

  WindInfo({this.speed, this.deg});

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'];
    final deg = json['deg'];
    return WindInfo(speed: speed, deg: deg);
  }
}
