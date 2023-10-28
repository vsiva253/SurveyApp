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
  List<dynamic> responses = [];
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
          responses = List.generate(surveyQuestions.length, (_) => null);
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
    prefs.setString('responses', json.encode(responses));
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
    final resultResponses =
        responses.map((response) => response.toString()).toList();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          responses: resultResponses,
          surveyQuestions: surveyQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (surveyQuestions.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final question = surveyQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildResponseField(question, currentQuestionIndex),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: previousQuestion,
                    child: Text('Previous'),
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

  Widget buildResponseField(SurveyQuestion question, int index) {
    if (question.answerType == AnswerType.InputField) {
      return TextFormField(
        onChanged: (value) {
          setState(() {
            responses[index] = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Your Answer',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.all(12.0),
        ),
      );
    } else if (question.answerType == AnswerType.SelectBox) {
      return DropdownButton<String>(
        isExpanded: true,
        items: question.options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            responses[index] = value;
          });
        },
        value: responses[index],
      );
    } else if (question.answerType == AnswerType.RadioBox) {
      return Column(
        children: question.options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: responses[index],
            onChanged: (value) {
              setState(() {
                responses[index] = value;
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
            value: responses[index]?.contains(option) ?? false,
            onChanged: (value) {
              setState(() {
                final List<String>? currentResponse = responses[index];
                if (value!) {
                  if (currentResponse == null) {
                    responses[index] = [option];
                  } else {
                    currentResponse.add(option);
                  }
                } else {
                  currentResponse?.remove(option);
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
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: responses[index] ?? ''),
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
                responses[index] = formattedDate;
              });
            }
          },
          decoration: InputDecoration(
            hintText: 'Select a date',
            contentPadding: EdgeInsets.all(12.0),
            border: InputBorder.none,
          ),
        ),
      );
    } else {
      return Text('Unsupported answer type');
    }
  }
}
