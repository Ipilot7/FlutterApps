import 'dart:convert';
import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel {
  @HiveField(0)
  String? date;
  @HiveField(1)
  List<dynamic>? today;
  @HiveField(2)
  List<dynamic>? weekDays;
  @HiveField(3)
  List<dynamic>? days;
  @HiveField(4)
  List<dynamic>? tempDay;
  @HiveField(5)
  List<dynamic>? block2;
  @HiveField(6)
  List<dynamic>? feeling;
  @HiveField(7)
  List<dynamic>? rainPerc;

  WeatherModel({
    this.date,
    this.today,
    this.weekDays,
    this.days,
    this.tempDay,
    this.block2,
    this.feeling,
    this.rainPerc,
  });

  @override
  String toString() {
    return 'WeatherModel(date: $date, today: $today, weekDays: $weekDays, days: $days, tempDay: $tempDay, tempNight: $block2, feeling: $feeling, rainPerc: $rainPerc)';
  }

  factory WeatherModel.fromDate03072022Today439272388C75104541959WeekDaysDaysTempDayTempNightFeelingRainPerc(
      Map<String, dynamic> data) {
    return WeatherModel(
      date: data['date'] as String?,
      today: data['today'] as List<String>?,
      weekDays: data['weekDays'] as List<dynamic>?,
      days: data['days'] as List<dynamic>?,
      tempDay: data['tempDay'] as List<dynamic>?,
      block2: data['block2'] as List<dynamic>?,
      feeling: data['feeling'] as List<dynamic>?,
      rainPerc: data['rainPerc'] as List<dynamic>?,
    );
  }

  Map<String, dynamic>
      toDate03072022Today439272388C75104541959WeekDaysDaysTempDayTempNightFeelingRainPerc() {
    return {
      'date': date,
      'today': today,
      'weekDays': weekDays,
      'days': days,
      'tempDay': tempDay,
      'block2': block2,
      'feeling': feeling,
      'rainPerc': rainPerc,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WeatherModel].
  factory WeatherModel.fromJson(String data) {
    return WeatherModel
        .fromDate03072022Today439272388C75104541959WeekDaysDaysTempDayTempNightFeelingRainPerc(
            json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WeatherModel] to a JSON string.
  String toJson() => json.encode(
      toDate03072022Today439272388C75104541959WeekDaysDaysTempDayTempNightFeelingRainPerc());

  WeatherModel copyWith({
    String? date,
    List<String>? today,
    List<dynamic>? weekDays,
    List<dynamic>? days,
    List<dynamic>? tempDay,
    List<dynamic>? block2,
    List<dynamic>? feeling,
    List<dynamic>? rainPerc,
  }) {
    return WeatherModel(
      date: date ?? this.date,
      today: today ?? this.today,
      weekDays: weekDays ?? this.weekDays,
      days: days ?? this.days,
      tempDay: tempDay ?? this.tempDay,
      block2: block2 ?? this.block2,
      feeling: feeling ?? this.feeling,
      rainPerc: rainPerc ?? this.rainPerc,
    );
  }
}
