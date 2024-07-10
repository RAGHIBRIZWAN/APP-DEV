import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_player/constants.dart';
import 'package:music_player/weathermodel.dart';


class WeatherApi{
  String apiKey = "ed95dd93ccb649bd921122841240207";
  
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async{
    String apiUrl = "$baseUrl?Key=$apiKey&q=$location";
    try{
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        return ApiResponse.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('Failed to load weather');
      }
    }catch(e){
      throw Exception('Failed to load weather');
    }
  }
}
