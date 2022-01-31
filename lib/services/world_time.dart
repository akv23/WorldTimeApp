// ignore_for_file: unused_local_variable

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  late String location; //location name for the ui
  late String time; //the time in that location
  late String flag; //url to the asset flag icon
  late String url; //location url for api and endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{

    try{
      
      //make the request
      Response response =  await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      
      Map data =  jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset']; 
      String offsetSign = data['utc_offset'].substring(0,1);
      String offsetHours = data['utc_offset'].substring(1,3);
      String offsetMinutes = data['utc_offset'].substring(4);
      
      DateTime now = DateTime.parse(datetime);

      if(offsetSign== '-')
        now = now.subtract(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));  
      else
      now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));

      //ser daytime
      isDaytime = now.hour > 6 && now.hour < 19 ? true :false;

      //set time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print(('Caght error: $e'));
      time = 'Could not get time data';
    }

  }

}
