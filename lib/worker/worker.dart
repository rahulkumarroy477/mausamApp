import 'package:http/http.dart' as http;
import 'dart:convert';

class Worker {
  String city = '';
  Map<String, dynamic> data = {};
  Worker(this.city) {
    city = city;
  }
  Future<void> getData() async {
    String loc, description, icon;
    double temp;
    double airspeed;
    int humidity;
    try {
      var url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=95e729facdd15a07b4476a6467379996";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      loc = "${json['coord']['lon']} ${json['coord']['lat']}";
      temp = json['main']['temp'];
      humidity = json['main']['humidity'];
      airspeed = json['wind']['speed'];
      description = json['weather'][0]['description'].toUpperCase();
      icon = json['weather'][0]['icon'];

      data = {
        'city': city,
        'loc': loc,
        'temp': temp-273.15,
        'humidity': humidity,
        'airspeed': airspeed,
        'desc': description,
        'icon': icon
      };
    } catch (e) {
      data = {
        'city': city,
        'loc': 'not found',
        'temp': 0.0,
        'humidity': 0,
        'airspeed': 0,
        'desc': 'not found',
        'icon': '02d'
      };
    }
  }

  Map<String, dynamic> setData() {
    getData();
    return {
      'city': data['city'],
        'loc': data['loc'],
        'temp': data['temp'],
        'humidity': data['humidity'],
        'airspeed': data['airspeed'],
        'desc': data['desc'],
        'icon': data['icon']
    };
  }
}
