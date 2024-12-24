import 'package:api_flutter/model/post_req_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostReq extends StatefulWidget {
  const PostReq({super.key});

  @override
  State<PostReq> createState() => _PostReqState();
}

// Function to make a POST request and return a DataModel object
Future<DataModel?> postData(String name, String job) async {
  var response = await http.post(
    Uri.https('reqres.in', 'api/users'),
    body: {"name": name, "job": job},
  );

  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 201) {
    String responseString = response.body;
    /// response string is given, string is converted to map, map into object
    /// This object is used to work with data
    return dataModelFromJson(responseString);
  } else {
    print('Failed to post data. Status: ${response.statusCode}');
    return null; // Return null for unsuccessful responses
  }
}

class _PostReqState extends State<PostReq> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  DataModel? _dataModel; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: const Text('Post Request'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.people,
                    color: Colors.amber,
                  ),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: jobController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.work,
                    color: Colors.amber,
                  ),
                  hintText: 'Job',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String job = jobController.text.trim();

                  if (name.isEmpty || job.isEmpty) {
                    // Validation for empty fields
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Name and Job cannot be empty")),
                    );
                    return;
                  }

                  // Make the POST request and store in DataModel's object
                  DataModel? data = await postData(name, job);

                  // Update the UI with the result
                  setState(() {
                    _dataModel = data;
                  });

                  if (_dataModel != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data Posted Successfully: ${_dataModel!.name} - ${_dataModel!.job}")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to Post Data")),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              if (_dataModel != null)
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("Name: ${_dataModel!.name}", style: const TextStyle(fontSize: 16)),
                        Text("Job: ${_dataModel!.job}", style: const TextStyle(fontSize: 16)),
                        Text("ID: ${_dataModel!.id}", style: const TextStyle(fontSize: 16)),
                        Text("Created At: ${_dataModel!.createdAt}", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
