import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_homework_12/components/body/general_status.dart';
import 'package:flutter_homework_12/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = '1c55ce71ecd840cbb8615858232702';
  String cityName = 'Riyadh';
  final cityNameController = TextEditingController();

  Future<Map<String, dynamic>> fetchWeatherData(String apiKey, String city) async {
    final response =
        await http.get(Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  String _getDayOfWeek(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('EEEE').format(date);
  }

  String getCurrentDateForAppbar() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('d MMMM, EEEE', 'en_US');
    return formatter.format(now);
  }

  @override
  void dispose() {
    cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 65.0, horizontal: 16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchWeatherData(apiKey, cityName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final forecast = snapshot.data!['forecast']['forecastday'];
              final aa = forecast[0]['day']['avgtemp_c'];
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            cityName,
                            style: Constants.kMediumTextStyle,
                          ),
                          const SizedBox(width: 12.0),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  Modelaa.modelData
                                      .add(ModelData(theNameOfCity: cityName, theTempOfCity: aa.toString()));
                                });
                              },
                              child: const Icon(Icons.favorite_border_outlined, size: 35.0, color: Colors.white)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Search'),
                                    content: TextField(
                                      controller: cityNameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter city name',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('CANCEL'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            cityName = cityNameController.text;
                                            cityNameController.clear();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text('SEARCH'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.search, size: 35.0, color: Colors.white),
                          ),
                          const SizedBox(width: 12.0),
                          InkWell(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const FavioratePage())),
                            child: const Icon(Icons.dashboard_outlined, size: 35.0, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        getCurrentDateForAppbar(),
                        style: Constants.kSmallTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    '${forecast[0]['day']['avgtemp_c']}°',
                    style: Constants.kLargeTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${forecast[0]['day']['condition']['text']}',
                        style: Constants.kSmallTextStyle,
                      ),
                      Image.network(
                        'https:${forecast[0]['day']['condition']['icon']}',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1f2329),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GeneralStatus(
                          icon: '💨',
                          value: '${(forecast[0]['day']['maxwind_kph'] / 3.6).toStringAsFixed(1)} m/s',
                          title: 'Wind',
                        ),
                        GeneralStatus(
                          icon: '💦',
                          value: '${forecast[0]['day']['avghumidity']}%',
                          title: 'Humidity',
                        ),
                        GeneralStatus(
                          icon: '☔️',
                          value: '${forecast[0]['day']['totalprecip_mm']} mm',
                          title: 'Rain',
                        ),
                      ],
                    ),
                  ),
                  for (var day in forecast)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getDayOfWeek(day['date']),
                            style: Constants.kForecastDayTextStyle,
                          ),
                          Text('${day['day']['mintemp_c']}°C', style: Constants.kSmallTextStyle),
                          SizedBox(
                            width: 50.0,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Color(0xFF4af2a1), Color(0xFF5cc9f5)],
                                ).createShader(bounds);
                              },
                              child: LinearProgressIndicator(
                                value: 0.5,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ),
                          Text('${day['day']['maxtemp_c']}°C', style: Constants.kForecastHighestTextStyle),
                          Image.network('https:${day['day']['condition']['icon']}', width: 40.0, height: 40.0),
                        ],
                      ),
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class FavioratePage extends StatefulWidget {
  const FavioratePage({super.key});

  @override
  State<FavioratePage> createState() => _FavioratePageState();
}

class _FavioratePageState extends State<FavioratePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faviorate'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          for (var i in Modelaa.modelData)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Color(0xff1f2329),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(0.0, 0.0), blurRadius: 10.0, spreadRadius: 5.0),
                ],
              ),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                children: [
                  Text(i.theNameOfCity, style: const TextStyle(color: Colors.white, fontSize: 20.0)),
                  const Spacer(),
                  Text(i.theTempOfCity.toString(), style: const TextStyle(color: Colors.white, fontSize: 20.0)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Modelaa {
  static final List<ModelData> modelData = [];
}

class ModelData {
  final String theNameOfCity;
  final String theTempOfCity;
  ModelData({required this.theNameOfCity, required this.theTempOfCity});
}
