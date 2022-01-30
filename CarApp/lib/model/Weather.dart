class Weather {
  double temp;
  String icon;
  String description;

  Weather({required this.temp, required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temp: json['current']['temp'].toDouble(),
        description: json['current']['weather'][0]['main'].toString(),
        icon: json['current']['weather'][0]['icon'].toString());
  }

  factory Weather.empty() {
    return Weather(temp: 0, description: '', icon: '01d');
  }
}