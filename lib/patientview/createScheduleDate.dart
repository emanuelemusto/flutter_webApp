import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webapp/patientList.dart';

import 'package:flutter/material.dart';
import 'package:flutter_webapp/patientview/patientHomeScreen.dart';
import 'package:flutter_webapp/patientview/scheduleList.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import 'createSchedule.dart';

class CreateScheduleDate extends StatefulWidget {
  Map<String, dynamic> practitioner;

  // receive data from the FirstScreen as a parameter
  CreateScheduleDate({Key key, @required this.practitioner}) : super(key: key);

  @override
  _CreateScheduleDate createState() => _CreateScheduleDate(this.practitioner);
}

class _CreateScheduleDate extends State<CreateScheduleDate> {
  Map<String, dynamic> practitioner;

  _CreateScheduleDate(this.practitioner);

  DateRangePickerController dateController = DateRangePickerController();

  List<String> data = new List<String>();

  Map<String, dynamic> list;

  List<DateTime> date = new List<DateTime>();

  List<String> date2 = new List<String>();

  Map<String, dynamic> list2;

  final format = DateFormat("dd/MM/yyyy");
  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;
  bool _validate8 = false;



  var now = new DateTime.now();

  Future<List<dynamic>> getData2() async {

    var sunday = 7;

    while (now.weekday != sunday) {
      now = now.subtract(new Duration(days: 1));
    }

    return date2;
  }


  String equalsName(String value) {
    String id;
    bool compare = false;
    var i = 0;
    while (i < data.length) {
      compare = data[i] == (value);
      if (compare) {
        id = list["entry"][i]["resource"]["id"];
      }
      i = i + 1;
    }

    setState(() {});
    return id;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    getData2();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
        print("1" + _selectedDate.toString());
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
        print("2" + _dateCount.toString());
      } else {
        _rangeCount = args.value.length.toString();
        print("3" + _rangeCount.toString());
      }
    });
  }

  String dropdownValue;
  var _selectedDate;
  var _dateCount;
  var _range;
  var _rangeCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.teal, Colors.teal],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.list_alt_rounded,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'Choice day of Schedule',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

                  SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    controller: dateController,
                    view: DateRangePickerView.month,
                    enablePastDates: false,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      blackoutDatesDecoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                              color: const Color(0xFFF44436), width: 1),
                          shape: BoxShape.circle),
                      weekendDatesDecoration: BoxDecoration(
                          color: const Color(0xFFDFDFDF),
                          border: Border.all(
                              color: const Color(0xFFB6B6B6), width: 1),
                          shape: BoxShape.circle),
                      specialDatesDecoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                              color: const Color(0xFF2B732F), width: 1),
                          shape: BoxShape.circle),
                      blackoutDateTextStyle: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough),
                      specialDatesTextStyle:
                          const TextStyle(color: Colors.white),
                    ),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 1,
                        weekendDays: [
                          6,
                          7
                        ],
                        blackoutDates: [
                          now.add((Duration(days: 7))),
                          now.add((Duration(days: 14))),
                          now.add((Duration(days: 21))),
                          now.add((Duration(days: 28))),
                          now.add((Duration(days: 35))),
                          now.add((Duration(days: 41))),
                          now.add((Duration(days: 48))),
                        ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      print(dateController.displayDate);
                      setState(() {
                        dateController == null
                            ? _validate3 = true
                            : _validate3 = false;
                      });

                      if (_validate3) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Form Error"),
                              content: new Text("Choice Date"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Form Success"),
                              content:
                                  new Text("Day selected"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Continue"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateSchedule(practitioner: practitioner , now: _selectedDate)),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );

                      }
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.tealAccent,
                              Colors.teal,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Continue'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
