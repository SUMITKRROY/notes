import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<LoadedEvent>((event, emit) async {
      emit(WeatherLoading());
      try{
        var dio = Dio();
        var response = await dio.request(
          'https://api.openweathermap.org/data/2.5/weather?q=${event.cities}&appid=930165a4649e9a547208f01e167e0a79',
          options: Options(
            method: 'GET',
          ),
        );

        if (response.statusCode == 200) {
          print(json.encode(response.data));
          var data = response.data;
          print("weather $data");
          emit(WeatherSuccess(data));
        }
        else {
          print(response.statusMessage);
        }
      }catch(e){
        emit(WeatherError());
      }
    });
  }
}
