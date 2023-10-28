import 'package:flutter/material.dart';
import 'package:thesurvey/entites/survey_model.dart';
import 'package:thesurvey/pages/home_page.dart';

class ResultPage extends StatelessWidget {
  final List<dynamic> responses;
  final List<SurveyQuestion> surveyQuestions;

  ResultPage({required this.responses, required this.surveyQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Results'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: surveyQuestions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value;
            final response = responses[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Question: ${question.question}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Response: ${response ?? 'Response not provided'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
