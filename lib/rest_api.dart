
import 'dart:collection';

import 'dart:convert';

 

import 'package:http/http.dart' as http;

 

class URLS {

 static const String BASE_URL = 'http://otaku-world.space:3000';

}

 

class ApiService {

 static Future<List> getAnimes() async {



    final response = await http.get('${URLS.BASE_URL}/anime');

    if (response.statusCode == 200) {

      var jsonObj = json.decode(response.body);

      return jsonObj;

    } else {

      return null;

    }

  }
  static Future<dynamic> getAnimeFromName(String name) async {



    final response = await http.get('${URLS.BASE_URL}/world/world?name=' + name);

    if (response.statusCode == 200) {

      var jsonObj = json.decode(response.body);

      return jsonObj;

    } else {

      return null;

    }

  }

 static Future<List> searchAnimes(String str) async {



   final response = await http.get('${URLS.BASE_URL}/anime/anime?search='+str);

   if (response.statusCode == 200) {

     var jsonObj = json.decode(response.body);

     return jsonObj;

   } else {

     return null;

   }

 }



  static Future<List> getAnimeEvidenza() async {

    final response = await http.get('${URLS.BASE_URL}/world/world?type=evidenza');



    if (response.statusCode == 200) {

      var jsonObj = json.decode(response.body);

      return jsonObj;

    } else {

      return null;

    }

  }

 static Future<List> getAnimeSuggeriti() async {

   final response = await http.get('${URLS.BASE_URL}/world/world?type=suggeriti');



   if (response.statusCode == 200) {

     var jsonObj = json.decode(response.body);

     return jsonObj;

   } else {

     return null;

   }

 }

 static Future<List> getAdvancedSearch(String url) async {

   final response = await http.get('${URLS.BASE_URL}' + url); //   L'url è del tipo /anime/anime?



   if (response.statusCode == 200) {

     var jsonObj = json.decode(response.body);

     return jsonObj;

   } else {

     return null;

   }

 }

 static Future<LinkedHashMap<String,dynamic>> getToday() async {

   final response = await http.get('${URLS.BASE_URL}/others/others?type=today');



   if (response.statusCode == 200) {

     var jsonObj = json.decode(response.body);

     return jsonObj;

   } else {
     return null;

   }

 }

 static Future<LinkedHashMap<String,dynamic>> getCalendario() async {

   final response = await http.get('${URLS.BASE_URL}/others/others?type=calendario');



   if (response.statusCode == 200) {

     var jsonObj = json.decode(response.body);

     return jsonObj;

   } else {

     return null;

   }

 }

 static Future<List> createUser(String token,String email,String pass,String username) async {

   var data = 'user_id='+token+'&mail='+email+'&pass='+pass+'&username='+username;

   final response = await http.post('${URLS.BASE_URL}/user', body: data);



   if (response.statusCode == 200) {

     var jsonObj = json.decode(response.body);

     return jsonObj;

   } else {

     return null;

   }

 }

 

 

}