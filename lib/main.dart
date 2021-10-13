import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_data_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  TextEditingController _searchCityNameController = TextEditingController();
  final _weatherDataService = WeatherDataService();
  WeatherModel? _weatherModelResponse;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_weatherModelResponse != null)
            _weatherModelResponse!.code != null
                ? Column(
                    children: [Text(_weatherModelResponse!.message!)],
                  )
                : Column(
                    children: [
                      _weatherModelResponse?.weatherInfo?.iconUrl != null
                          ? SizedBox(
                              width: screenWidth * 0.4,
                              height: screenWidth * 0.4,
                              child: Image.network(
                                _weatherModelResponse?.weatherInfo?.iconUrl ??
                                    "",
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : Text("No Icon Data"),
                      const SizedBox(height: 10),
                      Text(
                        '${_weatherModelResponse?.weatherInfo?.description}',
                        style: GoogleFonts.poppins(
                            fontSize: 26, fontWeight: FontWeight.w500),
                      ),
                      Column(
                        children: [
                          Text(
                            '${_weatherModelResponse?.temperaturInfo?.tempInfo} ℃',
                            style: GoogleFonts.poppins(
                                fontSize: 32, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_searchCityNameController.text}',
                            style: GoogleFonts.notoSans(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Wind now",
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${_weatherModelResponse!.windInfo!.speed}m/s",
                                style: GoogleFonts.notoSans(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Humidity",
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${_weatherModelResponse!.temperaturInfo!.humidity}%",
                                style: GoogleFonts.notoSans(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Feels Like",
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${_weatherModelResponse!.temperaturInfo!.feelsLike}℃",
                                style: GoogleFonts.notoSans(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: screenWidth * 0.6,
              child: TextField(
                controller: _searchCityNameController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'City Name',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            width: screenWidth * 0.8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
                onPressed: _searchCity,
                child: Text(
                  "Search for the weather",
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )),
          )
        ],
      ),
    );
  }

  void _searchCity() async {
    final response = await _weatherDataService.getWeatherData(
        cityName: _searchCityNameController.text);

    FocusScope.of(context).unfocus();

    setState(() {
      _weatherModelResponse = response;
    });
  }
}
