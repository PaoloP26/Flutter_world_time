import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; //time of location of the UI
  String flag; //url to asset flag icon
  String url; //location url for the api endpoint
  bool isDaytime; //true if day time

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);
      isDaytime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
