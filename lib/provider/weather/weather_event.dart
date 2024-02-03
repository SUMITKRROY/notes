part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}
class LoadedEvent extends WeatherEvent{
  String cities;

  LoadedEvent({required this.cities});
}