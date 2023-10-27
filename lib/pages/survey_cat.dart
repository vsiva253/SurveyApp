import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../authentication/data/repositories/users_repo.dart';
import '../constants/colors.dart';
import '../constants/values.dart';
import '../entites/survey_model.dart';
import '../utils/fonts.dart';

class SurveyCat extends StatefulWidget {
  const SurveyCat({super.key, required this.surveyCat});
  final String surveyCat;

  @override
  State<SurveyCat> createState() => _SurveyCatState();
}

class _SurveyCatState extends State<SurveyCat> {
    List<Survey> allSurvey = [];

    String pageLabel = '';

      initilizeValues() async {

      switch (widget.surveyCat) {
        case 'all_surveys_api':
          pageLabel = 'All Surveys';
          break;
        case 'surveys_get_api':
          pageLabel = 'Ongoing Surveys';
          
          break;
        case 'upcoming_get_api':
          pageLabel = 'Upcoming Surveys';
          
          break;
        case 'gets_survey_ans_api':
          pageLabel = 'Completed Surveys';
          
          break;
        default:
      }

    allSurvey = await getAllSurvey(apiStr: widget.surveyCat);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initilizeValues();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: Column(
          children: [
            Image.asset(
              logoPath,
              height: heightOfLogo,
            ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pageLabel,
                style: MainFonts.dashText(),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allSurvey.length,
                  itemBuilder: (context, index) {
                    Survey survey = allSurvey[index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: listColors[index % listColors.length],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            Image.asset(
                              'assets/images/school.png',
                              height: 100,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    survey.surveyName ?? '',
                                    style: MainFonts.pageTitleText(
                                        color: Colors.white),
                                  ),
                                  Text(
                                    survey.description ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Start Date: ${survey.createdAt != null ? survey.createdAt!.substring(0, 10) : ''}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Text(
                                    'End Date: ${survey.date != null ? survey.date!.substring(0, 10) : ''}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}