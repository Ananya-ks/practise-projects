import 'package:flutter/material.dart';

class MyNewRadioButton extends StatefulWidget {
  final String currentStatusToPass;
  final Function(String) onStatusChanged;
  MyNewRadioButton(
      {super.key,
      required this.currentStatusToPass,
      required this.onStatusChanged});

  @override
  State<MyNewRadioButton> createState() => _MyNewRadioButtonState();
}

List<String> newtaskStatus = ['Uncomplete', 'Completed'];

class _MyNewRadioButtonState extends State<MyNewRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Uncomplete',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            leading: Radio(
                activeColor: Colors.white,
                value: newtaskStatus[0],
                groupValue: widget.currentStatusToPass,
                onChanged: (value) {
                  widget.onStatusChanged(value.toString());
                }),
          ),
          ListTile(
            title: const Text(
              'Completed',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            leading: Radio(
                activeColor: Colors.white,
                value: newtaskStatus[1],
                groupValue: widget.currentStatusToPass,
                onChanged: (value) {
                  widget.onStatusChanged(value.toString());
                }),
          ),
        ],
      ),
    );
  }
}
