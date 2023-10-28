import 'package:flutter/material.dart';

import '../entites/survey_model.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> responses;
  final List<SurveyQuestion> surveyQuestions;

  ResultPage({required this.responses, required this.surveyQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Results'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: surveyQuestions.map((question) {
            final response = responses[question.id];
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Response: ${response ?? 'Response not provided'}',
                      style: const TextStyle(fontSize: 16),
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
