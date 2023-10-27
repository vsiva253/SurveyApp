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