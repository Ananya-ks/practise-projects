import 'package:flutter/material.dart';
import 'package:to_do_hive/pages/pages.dart';
import './my_button.dart';
import './my_radiobutton.dart';

class DialogBox extends StatefulWidget {
  final Function(String)? onSave;
  VoidCallback onCancel;
  final titlecontroller;
  final contentcontroller;
  DialogBox({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.contentcontroller,
    required this.titlecontroller,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  // by default sts is 'completed'
  String _currentStatusToPass = "Completed";

  void _handlestatusChange(String newSts) {
    setState(() {
      _currentStatusToPass = newSts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[700],
      content: Container(
        height: 300.0,
        width: 300.0,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              TextField(
                controller: widget.titlecontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new Ttile',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: widget.contentcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new Content',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyNewRadioButton(
                    currentStatusToPass: _currentStatusToPass,
                    onStatusChanged: _handlestatusChange,
                  ),
                ],
              ),
/// Initially, When MyRadioButton is called, the values are currentStatusTopass = 'Completed', onStatusChanged = reference of handleStsChange func
/// When MyRadioButton renders, 1st ListTile in MyNewRadioButton has values of, value: 'Uncomplete', groupValue: as currentSts is 'completed' it is not equal to the value. So the radiobutton is not selected.
/// When MyRadioButton renders, 1st ListTile in MyNewRadioButton has values of, value: 'Completed', groupValue: as currentSts is 'completed' it is equal to the value. So the radiobutton is selected.
/// When any change in selection of radiovalue happens, onChanged property is triggered with a callback onStatusChanged with current changed value as parameter.
/// EX: When changing from default 'Completed' to 'Uncompleted', onStatusChanged is triggered with the value 'Uncompleted' so, it is passed to handleStsChange. it sets the currentStsToPass as Uncompleted. so when widget tree rebuilts, the groupValue is updated to 'Uncompleted' 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyNewButton(
                      text: 'SAVE',
                      onPressed: () {
                        if (widget.onSave != null) {
                          widget.onSave!(_currentStatusToPass);
                        }
                      }),
                  MyNewButton(text: 'CANCEL', onPressed: widget.onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
