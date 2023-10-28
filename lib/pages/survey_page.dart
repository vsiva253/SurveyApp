import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entites/survey_model.dart';
import 'survey_results.dart';

class SurveyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<SurveyQuestion> surveyQuestions = [];
  Map<String, dynamic> responses = {};
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchSurveyQuestions();
  }

  Future<void> fetchSurveyQuestions() async {
    final apiUrl = 'https://www.surveyfriendly.com/Api/question_get_api';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'category': '40'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          surveyQuestions =
              data.map((item) => SurveyQuestion.fromJson(item)).toList();
        });
      } else {
        print('Failed to fetch survey questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void submitSurvey() {
    saveResponsesToLocal();
    showResultPage();
  }

  void saveResponsesToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final savedResponses = prefs.getString('responses');

    Map<String, dynamic> storedResponses = {};

    if (savedResponses != null) {
      storedResponses = json.decode(savedResponses);
    }

    storedResponses.addAll(responses);

    prefs.setString('responses', json.encode(storedResponses));
  }

  void loadResponsesFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final savedResponses = prefs.getString('responses');
    if (savedResponses != null) {
      responses = json.decode(savedResponses);
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < surveyQuestions.length - 1) {
      setState(() {
        // Remove the response for the current question
        responses.remove(surveyQuestions[currentQuestionIndex].id);
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void showResultPage() {
    loadResponsesFromLocal();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          responses: responses,
          surveyQuestions: surveyQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (surveyQuestions.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final question = surveyQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      question.question,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    buildResponseField(question),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: previousQuestion,
                    child: const Text('Previous'),
                  ),
                ElevatedButton(
                  onPressed: currentQuestionIndex == surveyQuestions.length - 1
                      ? submitSurvey
                      : nextQuestion,
                  child: Text(
                    currentQuestionIndex == surveyQuestions.length - 1
                        ? 'Submit'
                        : 'Next',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResponseField(SurveyQuestion question) {
    // Implement response fields based on answer type
    if (question.answerType == AnswerType.InputField) {
      return TextFormField(
        onChanged: (value) {
          setState(() {
            responses[question.id] = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Your Answer', // Add a label for the input field
          border: OutlineInputBorder(
            // Add a border around the input field
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.all(
              12.0), // Add padding to the input field content
        ),
      );
    } else if (question.answerType == AnswerType.SelectBox) {
      return SingleChildScrollView(
        // Wrap the DropdownButton in a SingleChildScrollView
        child: DropdownButton<String>(
          isExpanded:
              true, // This allows the DropdownButton to take up available vertical space
          items: question.options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              responses[question.id] = value;
            });
          },
          value: responses[question.id],
        ),
      );
    } else if (question.answerType == AnswerType.RadioBox) {
      return Column(
        children: question.options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: responses[question.id],
            onChanged: (value) {
              setState(() {
                responses[question.id] = value;
              });
            },
          );
        }).toList(),
      );
    } else if (question.answerType == AnswerType.CheckBox) {
      return Column(
        children: question.options.map((option) {
          return CheckboxListTile(
            title: Text(option),
            value: responses[question.id]?.contains(option) ?? false,
            onChanged: (value) {
              setState(() {
                if (value!) {
                  responses[question.id] = [
                    ...(responses[question.id] ?? []),
                    option
                  ];
                } else {
                  responses[question.id]?.remove(option);
                }
              });
            },
          );
        }).toList(),
      );
    } else if (question.answerType == AnswerType.InputBoxDate) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Add a border color
            width: 1.0, // Add border width
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: responses[question.id] ?? ''),
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
              setState(() {
                responses[question.id] = formattedDate;
              });
            }
          },
          decoration: const InputDecoration(
            hintText: 'Select a date',
            contentPadding: EdgeInsets.all(12.0),
            border: InputBorder.none, // Remove the default input border
          ),
        ),
      );
    } else {
      return const Text('Unsupported answer type');
    }
  }
}
