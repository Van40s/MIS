import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // For calendar display
import 'package:lab_04_211244_v2/models/exam.dart';
import 'package:lab_04_211244_v2/service/firebase_service.dart';
// import 'package:latlong2/latlong.dart';
// import 'route_map_page.dart';
// import 'package:lab_04_211244_v2/service/location_service.dart';
import 'package:lab_04_211244_v2/page/add_exam_page.dart';
import 'package:lab_04_211244_v2/page/route_map_page.dart';

class ExamListPage extends StatefulWidget {
  @override
  _ExamListPageState createState() => _ExamListPageState();
}

class _ExamListPageState extends State<ExamListPage> {
  final FirebaseService firebaseService = FirebaseService();
  List<Exam>_examEvents = List.empty();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now(); // Initialize with today's date
    _fetchExams(); // Fetch exams for today
  }

  void _fetchExams() async {
  if (_selectedDay != null) {
    print("Selected day: $_selectedDay");
    final exams = await firebaseService.getExamsByDate(_selectedDay!);
    print('Fetched exams: $exams');
    print(exams.runtimeType);

    // Update the state to display the exams for the selected day
    setState(() {
      _examEvents = exams;
    });
    print(_examEvents);
  }
}

  // Navigate to add exam page
  void _addExam() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExamPage()),
    ).then((_) => _fetchExams()); // Refresh exams after adding
  }

  // Method to handle opening the map page with the selected exam
  void _openMap(Exam exam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouteMapPage(exam: exam), // Passing exam data to RouteMapPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam List')),
      body: Column(
        children: [
          // Calendar widget to select a day
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _fetchExams(); // Fetch exams for the selected day
            },
          ),

          // Display the exams for the selected day
          Expanded(
            child: _examEvents.length > 0
                ? ListView.builder(
                    itemCount: _examEvents.length,
                    itemBuilder: (context, exam_index) {
                      final exam = _examEvents[exam_index];
                      return ListTile(
                        title: Text(exam.title),
                        subtitle: Text('${exam.datetime.toLocal()}'), 
                        trailing: IconButton(
                          icon: Icon(Icons.map),
                          onPressed: () => _openMap(exam), // Open map on button press
                        ),// Display DateTime in local format
                      );
                    },
                  )
                : const Center(child: Text('No exams for the selected day.')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExam,
        tooltip: 'Add Exam',
        child: const Icon(Icons.add),
      ),
    );
  }
}