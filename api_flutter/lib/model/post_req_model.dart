// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

/// Deserialisation - converts JSON string into Dart map to Object

/// json.decode - converts string to Map
/// .fromJSON - converts Map into Dart Object and maps its field to the instance of class
DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));


/// Serialization - Object (class) to Map to JSON String (encode)

/// .toJSON - converts object into Map (EX: dataModelObj.name into dataMap['name'])
/// json.encode - converts map into JSON string to store in plain-text format
String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    String name;
    String job;
    String id;
    DateTime createdAt;

    DataModel({
        required this.name,
        required this.job,
        required this.id,
        required this.createdAt,
    });

    /// converts from JSON map to object
    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    /// converts object to JSON Map
    Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}
