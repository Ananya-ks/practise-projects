import 'package:api_flutter/model/user_dob.dart';
import 'package:api_flutter/model/user_location.dart';
import 'package:api_flutter/model/user_name.dart';
import 'package:api_flutter/model/user_picture.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final UserDob dob;
  final UserLocation location;
  final UserPicture picture;

  User(
      {required this.gender,
      required this.email,
      required this.phone,
      required this.cell,
      required this.nat,
      required this.name,
      required this.dob,
      required this.location,
      required this.picture
      });

  /// getter for combining title, first, last. The getter's return type is String
  /// Getter fullName can be accessed as property using .fullName instead of .fullName()
  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }
}

/// below Username can be used in new file(user_name.dart) for cleaner code

// class UserName {
//   final String title;
//   final String first;
//   final String last;

//   UserName({
//     required this.title,
//     required this.first,
//     required this.last,
//   });
// }
