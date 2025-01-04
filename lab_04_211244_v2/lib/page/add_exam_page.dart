import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lab_04_211244_v2/service/firebase_service.dart';
import 'package:lab_04_211244_v2/models/exam.dart';
import 'package:latlong2/latlong.dart';
import 'map_picker_page.dart';

class AddExamPage extends StatefulWidget {
  @override
  _AddExamPageState createState() => _AddExamPageState();
}

class _AddExamPageState extends State<AddExamPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  DateTime? selectedDateTime;
  String? selectedLocation;

  FirebaseService firebaseService = FirebaseService();

  void _submit() {
    if (_formKey.currentState!.validate() &&
        selectedDateTime != null &&
        selectedLocation != null) {
      
      // Convert selectedLocation string to GeoPoint
      List<String> locationParts = selectedLocation!.split(', ');
      double latitude = double.parse(locationParts[0]);
      double longitude = double.parse(locationParts[1]);
      GeoPoint geoPoint = GeoPoint(latitude, longitude);
      
      Exam exam = Exam(
        id: '',
        title: title,
        datetime: selectedDateTime!,
        location: geoPoint!,
      );
      firebaseService.addExam(exam).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exam added successfully!')),
        );
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Exam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title input
              TextFormField(
                decoration: InputDecoration(labelText: 'Exam Title'),
                onChanged: (value) => title = value,
                validator: (value) =>
                    value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              SizedBox(height: 16),
              // Date and time picker
              TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (date) => setState(() => selectedDateTime = date),
                  );
                },
                child: Text(selectedDateTime == null
                    ? 'Select Date and Time'
                    : selectedDateTime!.toString()),
              ),
              SizedBox(height: 16),
              // Map picker for location
              TextButton(
                onPressed: () async {
                  final LatLng? location = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPickerPage()),
                  );

                  if (location != null) {
                    setState(() {
                      selectedLocation = '${location.latitude}, ${location.longitude}';
                    });
                  }
                },
                child: Text(selectedLocation == null
                    ? 'Select Location'
                    : selectedLocation!),
              ),
              SizedBox(height: 16),
              // Submit button
              ElevatedButton(
                onPressed: _submit,
                child: Text('Save Exam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
