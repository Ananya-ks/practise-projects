import 'package:flutter/material.dart';
import 'component.dart';

void main() {
  runApp(const MaterialApp(home: MyId()));
}

class MyId extends StatefulWidget {
  const MyId({super.key});

  @override
  State<MyId> createState() => _MyIdState();
}

class _MyIdState extends State<MyId> {
  // bool _isHovered = false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[200],
      appBar: AppBar(
        title: const Text(
          'USERS - ID',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[600],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/image.jpg'),
                  radius: 50.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/image-2.jpg'),
                  radius: 50.0,
                ),
              ],
            ),
          ),
          Divider(height: 50.0, color: Colors.deepOrange[100]),
          Row(
            children: [
              Expanded(
                child: Container(
                    height: 200.0,
                    width: 200.0,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NAME',
                          style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Ananya',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 100.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.deepOrange[500],
                              size: 20.0,
                            ),
                            const Text('123@gmail.com'),
                          ],
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NAME',
                        style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Satheesh',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 80.0,
                      ),
                      Tooltip(
                        message: 'anu123@gmail.com',
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail,
                                color: Colors.deepOrange[500],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Mail me',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.deepOrange[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // ignore: sized_box_for_whitespace
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 190.0),
            child: Container(
              width: 190.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Component()));
                },
                child: const Row(
                  children: [
                    Icon(Icons.last_page_sharp),
                    Text('Component page')
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 70.0,
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.fromLTRB(95.0, 20.0, 87.0, 20.0),
            child: Text(
              'You\'ve clicked "+" $counter times',
              style: const TextStyle(
                fontFamily: 'IndieFlower',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        child: const Icon(Icons.add),
        // tooltip: ,
      ),
    );
  }
}
