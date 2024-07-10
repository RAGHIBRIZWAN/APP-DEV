import 'package:flutter/material.dart';
import 'package:music_player/api.dart';
import 'package:music_player/weathermodel.dart';
import 'package:music_player/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ApiResponse? response;
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchWidget(),
              const SizedBox(height: 20),
              if (inProgress)
                CircularProgressIndicator()
              else
                Expanded(child: SingleChildScrollView(child: _buildWeatherWidget())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: 'Search any location',
      onSubmitted: (value) {
        _getWeatherData(value);
      },
    );
  }

  Widget _buildWeatherWidget() {
    if (response == null) {
      return Text('Search for the location to get weather');
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.location_on, size: 50),
              Text(response?.location?.name ?? "",style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Colors.white
              ),),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(response?.location?.country ?? "",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((response?.current?.tempC.toString() ?? "") + " °c",style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                  color: Colors.white
                ),),
              ),
              Text((response?.current?.condition?.text.toString() ?? "") + " °c",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          Center(
            child: SizedBox(
              height: 200,
                child: Image.network('https:${response?.current?.condition?.icon}'.replaceAll("64x64", "128x128"))
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Humidity",response?.current?.humidity?.toString()??""),
                    _dataAndTitleWidget("Wind Speed",(response?.current?.windKph?.toString()??"") + ' km/h'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("UV",response?.current?.uv?.toString()??""),
                    _dataAndTitleWidget("Precipitation","${response?.current?.precipMm?.toString()??""} mm"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget(
                        "Local Time",
                        response?.location?.localtime?.split(" ").last ?? ""
                    ),
                    _dataAndTitleWidget(
                        "Local Date",
                        response?.location?.localtime?.split(" ").first ?? ""
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(String title,String data){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(data,style: const TextStyle(fontSize: 27,color: Colors.black87,fontWeight: FontWeight.w600),),
          Text(title,style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      ApiResponse weatherResponse = await WeatherApi().getCurrentWeather(location);
      setState(() {
        response = weatherResponse;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      // Optionally, you can show a dialog or a SnackBar with the error message
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
