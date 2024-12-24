import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Components'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext ctx) {
                          return Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 400, 0, 0),
                                child: SizedBox(
                                  // height: MediaQuery.of(ctx).size.height,
                                  // width: double.infinity,
                                  child: Center(
                                    child: Text('hello'),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text('Exit'),
                              )
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.info_outline)),
            )
          ],
        ),
        /// persistentFooter button displays textbuttons, even if scaffold is scrollable
        persistentFooterButtons: [
          TextButton(
            onPressed: () {
              debugPrint('Save button pressed');
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              debugPrint('Cancel button pressed');
            },
            child: const Text('Cancel'),
          ),
        ],
        
        /// aligns persistentfooter Textbuttons
        persistentFooterAlignment: AlignmentDirectional.center,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100.0,
              ),
              //Materialbanner
              ElevatedButton(
                child: const Text('Open Material Banner'),
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showMaterialBanner(
                    MaterialBanner(
                      padding: const EdgeInsets.all(10),

                      ///content --> typically a Text widget
                      content: const Text('Subscribe'),
                      //leading --> typically an Icon widget
                      leading: const Icon(Icons.notifications_active_rounded),

                      ///elevation --> shadow range
                      elevation: 5.0,
                      backgroundColor: Colors.amber,
                      actions: [
                        TextButton(
                          onPressed: () {
                            scaffoldMessengerKey.currentState
                                ?.hideCurrentMaterialBanner();
                          },
                          child: const Text('Dismiss'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              //Snackbar button
              ElevatedButton(
                child: const Text('Snackbar Button'),
                onPressed: () {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content:
                          const Text('Snackbar that automatically disables'),
                      duration: const Duration(seconds: 10),
                      backgroundColor: Colors.deepOrange[600],
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          scaffoldMessengerKey.currentState?.showSnackBar(
                            const SnackBar(
                              content: Text('Restored UNDO'),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              //Modal bottom sheet
              ElevatedButton(
                child: const Text('Modal bottom sheet'),
                onPressed: () {
                  showModalBottomSheet(
                    /// prevents modal window from automatic closing, if tapped on emoty area
                    // isDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        /// makes the height of modal to the height of context
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            const Center(
                              child: Text(
                                'Modal content',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              //Alert Button
              ElevatedButton(
                child: const Text('Alert button'),
                onPressed: () {
                  showDialog(
                    context: context,

                    /// disables automatic leaving when touched in empty area
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Alert Box'),
                        content: const Text('This is an alert box'),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[700],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[400],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
