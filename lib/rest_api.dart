import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class URLS {
 static const String BASE_URL = 'http://otaku-world.space:3000';
}

class ApiService {
  static Future<dynamic> getMangas() async {
    final response = await http.get('${URLS.BASE_URL}/manga/5be372f8719a160a9e36dbaa?all=1');
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }
   static Future<dynamic> getCapitolo(String cap) async {
    final response = await http.get('${URLS.BASE_URL}/manga/' + cap + '?capitolo=1');
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }
  static Future<dynamic> getSingleManga(String id) async {
    final response = await http.get('${URLS.BASE_URL}/manga/' + id + '?manga=1');
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }
  static Future<List> getAnimes() async {
    final response = await http.get('${URLS.BASE_URL}/world');
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
    final response = await http.get('${URLS.BASE_URL}/world/world?search='+str);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }
  static Future<dynamic> randomAnime() async {
    final response = await http.get('${URLS.BASE_URL}/world/world?random=1');
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }

  static Future<dynamic> takeDataFromCloud(String email) async {
    var url = '${URLS.BASE_URL}/test?email=' + email + '&type=output';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }
  static Future<dynamic> sendDataOnCloud(String email, List<dynamic> preferiti, List<dynamic> attivita) async {
    var pref = preferiti.map((pref)=>pref['name']).join(',');
    var att = attivita.map((act)=>act['anime'] + '00xxnumxx00' +  act['episodio']).join(',');
    
    var url = '${URLS.BASE_URL}/test?email=' + email + '&type=input&preferiti='+pref.toString()+'&attivita='+att.toString();
    final response = await http.get(url);
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