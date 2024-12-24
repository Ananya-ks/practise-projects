import 'dart:convert';
import 'package:api_flutter/model/user.dart';
import 'package:api_flutter/model/user_dob.dart';
import 'package:api_flutter/model/user_location.dart';
import 'package:api_flutter/model/user_name.dart';
import 'package:api_flutter/model/user_picture.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> fetchUser() async {
    /// url is always a string, to convert it to uri object, we use Uri.parse()
    const urlString = 'https://randomuser.me/api/?results=5';

    /// uri has domain name, path, query, params etc., which can be accessed and used
    final uri = Uri.parse(urlString);

    /// response contains headers, body etc.,
    final response = await http.get(uri);

    /// expected result will be in body
    final body = response.body;

    /// body will always be in form of String
    /// to use in code, we need JSON. So string is converted into JSON (Map) by using jsonDecode
    final json = jsonDecode(body);

    /// updating the List of users with the value of result key in json obj
    // setState(() {
    //   users = json['results'];
    // });

    /// after converting json into Map, json's result value is converted to List
    final results = json['results'] as List<dynamic>;

    /// mapping each result to User's details. As users is a List, transformed is also converted into list
    final transformed = results.map((toElement) {
      final username = UserName(
          title: toElement['name']['title'],
          first: toElement['name']['first'],
          last: toElement['name']['last']);

      final userdob = UserDob(
          date: DateTime.parse(toElement['dob']['date']),
          age: toElement['dob']['age']);
      final street = LocationStreet(
          number: toElement['location']['street']['number'],
          name: toElement['location']['street']['name']);
      final userlocation = UserLocation(
          city: toElement['location']['city'],
          state: toElement['location']['state'],
          country: toElement['location']['country'],
          postcode: toElement['location']['postcode'].toString(),
          street: street
          );
      final userpicture = UserPicture(
        large: toElement['picture']['large'], 
        medium: toElement['picture']['medium'], 
        thumbnail: toElement['picture']['thumbnail']);

      return User(
        gender: toElement['gender'],
        email: toElement['email'],
        phone: toElement['phone'],
        cell: toElement['cell'],
        nat: toElement['nat'],
        name: username,
        dob: userdob,
        location: userlocation,
        picture: userpicture,
      );
    }).toList();

    /// here setstate cannot be used because it is used in stateful widget. So we should return the result ie., transformed
    // setState(() {
    //   users = transformed;
    // });
    print('User fetched');

    return transformed;
  }
}
