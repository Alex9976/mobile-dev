class Weather {
  double temp;
  String icon;
  String description;

  Weather({required this.temp, required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json)
  {
    return Weather(
        temp: json['current']['temp'].toDouble(),
        description: json['current']['lon'].toString(),
        icon: json['current']['lon'].toString());
  }
}


// {lat} = 33.44
// {lon} = -94.04
// {key} = 94dc1074110348afc7eaa29770732d95
//https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&exclude=minutely,daily,hourly,alerts&units=metric&appid={key}