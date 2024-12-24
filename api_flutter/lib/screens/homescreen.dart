// ignore_for_file: avoid_print

import 'package:api_flutter/model/user.dart';
import 'package:api_flutter/screens/post_req.dart';
import 'package:api_flutter/services.dart/user_api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  List<User> users = [];
  bool isLoadingMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API'),
      ),
      body: ListView.builder(

          /// scrollcontroller - used to control the scrolling behaviour
          controller: scrollController,
          itemCount: isLoadingMore ? users.length + 1 : users.length,
          itemBuilder: (ctx, index) {
            if (index < users.length) {
              print("index: ${index}");
              print("user length: ${users.length}");

              /// to access 1 user at a time
              final user = users[index];

              /// instead of accessing values like this, a separate model class can be created

              // final email = user["email"];
              // final titleName = user["name"]["title"];
              // final firstName = user["name"]["first"];
              // final lastName = user["name"]["last"];
              // final picture = user["picture"]["medium"];

              return ListTile(
                title: Text(user.fullName),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Text('${index + 1}'),
                ),
                // title: Text(user.fullName),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          user.picture.thumbnail,
                          height: 100.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.email),
                            Text('${user.dob.date}'),
                            Text('${user.dob.age}'),
                            Text(user.location.city),
                            Text(user.location.country),
                            Text(user.location.postcode),
                            Text(user.location.state),
                            Text(user.location.street.name),
                            Text('${user.location.street.number}'),
                            Text(user.cell),
                            Text(user.phone),
                            Text(user.nat),
                            Text(user.gender)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const PostReq()));
        },
        child: const Icon(Icons.post_add_sharp),
      ),
    );
  }

  /// initially whenever the page loads
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchUser();
  }

  Future<void> fetchUser() async {
    final response = await UserApi.fetchUser();

    /// here updating the user state and to update in UI setState must be used.
    setState(() {
      users = users + response;
    });
  }

  Future<void> _scrollListener() async {
    /// used to check whether the user has scrolled to bottom of the widget
    /// It is used for infinite scrolling/ pagination, lazy loading (fetch additional content only when necessary), trigger actions like circularprogressbar
    /// When bttom is reached, Loading more status is set to true,
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      print('Call done');

      /// after reaching bottom, again fetching the users,
      await fetchUser();

      /// after fetching users (defaultly 10) loading more status is set to false
      setState(() {
        isLoadingMore = false;
      });
    } else {
      print("Scroll done");
    }
  }

  /// below code must be in Services, not in UI file
//   Future<void> fetchUser() async {
//     /// url is always a string, to convert it to uri object, we use Uri.parse()
//     const urlString = 'https://randomuser.me/api/?results=10';

//     /// uri has domain name, path, query, params etc., which can be accessed and used
//     final uri = Uri.parse(urlString);

//     /// response contains headers, body etc.,
//     final response = await http.get(uri);

//     /// expected result will be in body
//     final body = response.body;
//     print('User fetched');

//     /// body will always be in form of String
//     /// to use in code, we need JSON. So string is converted into JSON (Map) by using jsonDecode
//     final json = jsonDecode(body);

//     /// updating the List of users with the value of result key in json obj
//     // setState(() {
//     //   users = json['results'];
//     // });

//     /// after converting json into Map, json's result value is converted to List
//     final results = json['results'] as List<dynamic>;

//     /// mapping each result to User's details. As users is a List, transformed is also converted into list
//     final transformed = results.map((toElement) {
//       final username = UserName(
//         title: toElement['name']['title'],
//         first: toElement['name']['first'],
//         last: toElement['name']['last']);
//       return User(
//           gender: toElement['gender'],
//           email: toElement['email'],
//           phone: toElement['phone'],
//           cell: toElement['cell'],
//           nat: toElement['nat'],
//           name: username,
//           );
//     }).toList();
//     setState(() {
//       users = transformed;
//     });
//   }
// }
}
