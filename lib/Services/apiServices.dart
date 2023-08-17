import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webullish/Services/apiConst.dart';

class apiServices {
  AuthRequest({required String url}) async {
    var prefs = await SharedPreferences.getInstance();

    var email = prefs.get('email');
    var pass = prefs.get('pass');
    var body = email == null
        ? {'email': 'guest@guest.com', 'password': '12345678'}
        : {'email': email, 'password': pass};

    try {
      var response = await http.post(Uri.parse(apiConst.baseUrl + url),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        await prefs.setString('userjwt', responsebody['access_token']);
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<List<dynamic>> getRequest(String url) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt_token = await prefs.getString('userjwt');

    try {
      var response = await http.get(Uri.parse(apiConst.baseUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt_token'
          });

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      }

      if (response.statusCode == 401) {
        // AuthRequest(url: apiConst.logIn);
        // getRequest(url);
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return [
          {'error': response.statusCode}
        ];
      }
    } catch (e) {
      return [
        {"error": e}
      ];
    }
  }

  Future<Map<dynamic, dynamic>> getRequestMap(String url) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt_token = await prefs.getString('userjwt');

    try {
      var response = await http.get(Uri.parse(apiConst.baseUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt_token'
          });

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      }

      if (response.statusCode == 401) {
        AuthRequest(url: apiConst.logIn);
        getRequestMap(url);
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return {'error': response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<dynamic, dynamic>> getprofile(String url, jwt) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt_token = jwt;

    try {
      var response = await http.get(Uri.parse(apiConst.baseUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt_token'
          });

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      }

      if (response.statusCode == 401) {
        AuthRequest(url: apiConst.logIn);
        // getRequest(url);
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return {'error': jsonDecode(response.body)};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<dynamic, dynamic>> postProfile(String url, jwt) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt_token = jwt;

    try {
      var response = await http.post(Uri.parse(apiConst.baseUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt_token'
          });

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      }

      if (response.statusCode == 401) {
        //   AuthRequest(url: apiConst.logIn);
        //     postProfile(url, jwt);
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return {'error': jsonDecode(response.body)};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<dynamic, dynamic>> postRequestMap(
      {required url, required body}) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt_token = prefs.getString('userjwt');

    try {
      var response = await http.post(Uri.parse(apiConst.baseUrl + url),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt_token'
          });

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      }

      if (response.statusCode == 401) {
        AuthRequest(url: apiConst.logIn);
        postRequestMap(url: url, body: body);
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return {'error': response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<dynamic, dynamic>> postRequest(
      String url, Map map, String jwt) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: json.encode(map), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        return {"error": response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<String, dynamic>> apiPut({
    url,
    body,
  }) async {
    try {
      var response = await http.put(Uri.parse('$url'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(body));

      if (response.statusCode == 401) {}
      if (response.statusCode == 403) {}
      if (response.statusCode == 200) {
        return {'response': response.statusCode};
      }

      return {'error': response.body};
    } catch (e) {
      return {'error': e};
    }
  }

  Future<Map<String, dynamic>> apiDelete(url) async {
    try {
      var response =
          await http.delete(Uri.parse('$url'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 401) {}
      if (response.statusCode == 403) {}
      if (response.statusCode == 200) {
        return {'response': response.statusCode};
      }

      return {'error': response.statusCode};
    } catch (e) {
      return {'error': e};
    }
  }
}
