import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/provider/weather/weather_bloc.dart';
import 'package:notes/utils/colors.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({Key? key}) : super(key: key);

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc.add(LoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black12,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.white),
        backgroundColor: CustomColors.black12,
        title: Text(
          "Today's Weather",
          style: TextStyle(color: CustomColors.white),
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccess) {
            Map<String, dynamic> data = state.weatherData;
            return _buildWeatherUI(data);
          } else if(state  is WeatherError) {
            return Center(
              child: Text('Failed to load weather data'),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildWeatherUI(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: ${data['name']}',
              style: TextStyle(fontSize: 20, color: CustomColors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Temperature: ${data['main']['temp']}°C',
              style: TextStyle(fontSize: 20, color: CustomColors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${data['weather'][0]['description']}',
              style: TextStyle(fontSize: 20, color: CustomColors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Humidity: ${data['main']['humidity']}%',
              style: TextStyle(fontSize: 20, color: CustomColors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Wind Speed: ${data['wind']['speed']} m/s',
              style: TextStyle(fontSize: 20, color: CustomColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
