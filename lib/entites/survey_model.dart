import 'dart:convert';

class Survey {
  String? id;
  String? surveyName;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? surveyStatus;
  String? status;
  String? startDate;
  String? endDate;
  String? date;
  String? surveyId;
  String? userId;
  String? userType;
  String? category;
  String? cDiv;
  String? cCompany;

  Survey({
    this.id,
    this.surveyName,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.surveyStatus,
    this.status,
    this.date,
    this.surveyId,
    this.userId,
    this.userType,
    this.startDate,
    this.endDate,
    this.cDiv,
    this.cCompany,
    this.category,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['id'],
      surveyName: json['survey_name'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      surveyStatus: json['survey_status'],
      status: json['status'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      surveyId: json['survey_id'],
      userId: json['user_id'],
      userType: json['user_type'],
      category: json['category'],
      date: json['date'],
      cDiv: json['c_div'],
      cCompany: json['c_company'],
    );
  }
}

class SurveyQuestion {
  final String id;
  final String question;
  final AnswerType answerType;
  final List<String> options;

  SurveyQuestion({
    required this.id,
    required this.question,
    required this.answerType,
    required this.options,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['id'] as String,
      question: json['questiontitle'] as String,
      answerType: AnswerTypeExtension.fromString(json['ansertype']),
      options: (json['optionlist'] as String)
          .split(',')
          .map((opt) => opt.trim())
          .toList(),
    );
  }
}

enum AnswerType {
  InputField,
  SelectBox,
  RadioBox,
  CheckBox,
  InputBoxDate,
}

extension AnswerTypeExtension on AnswerType {
  static AnswerType fromString(String value) {
    switch (value) {
      case '1':
        return AnswerType.InputField;
      case '2':
        return AnswerType.SelectBox;
      case '3':
        return AnswerType.RadioBox;
      case '4':
        return AnswerType.CheckBox;
      case '5':
        return AnswerType.InputBoxDate;
      default:
        return AnswerType.InputField;
    }
  }
}
