import 'package:http/http.dart' as http;
import 'package:thesurvey/utils/items.dart';
import 'package:thesurvey/utils/methods.dart';
import 'dart:convert';

import '../../../constants/values.dart';
import '../../../entites/survey_model.dart';


Future<int> getCity() async {
  final String apiUrl = '${apiEndPoint}/city_survey_api';

  // Make a POST request to the API
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    List<dynamic> cityData = json.decode(response.body);

    Items.citys = cityData.map<String>((city) => city['city'] as String).toList();
    return 1;
  } else {
    return -1;
  }
}

Future<int> getSurveyCount(String surveytype) async {
  String apiUrl = '';

  switch (surveytype) {
    case 'total':
      apiUrl = '${apiEndPoint}/total_survey_count_api?user_id=${usertype}';
      break;
      
    case 'ongoing':
      apiUrl = '${apiEndPoint}/ongoing_survey_count_api?user_id=${usertype}';
      break;

    case 'upcomming':
      apiUrl = '${apiEndPoint}/ongoing_survey_count_api?user_id=${usertype}';
      break;

    case 'completed':
          apiUrl = '${apiEndPoint}/complete_survey_count_api?user_id=${usertype}';
          break;
  }

  // Make a POST request to the API
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
     final data = json.decode(response.body);

    return data['surveys'];
  } else {
    return -1;
  }
}

Future<int> getStates() async {
  final String apiUrl = '${apiEndPoint}/state_survey_api';

  // Make a POST request to the API
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    List<dynamic> cityData = json.decode(response.body);

    Items.state = cityData.map<String>((city) => city['state'] as String).toList();
    return 1;
  } else {
    return -1;
  }
}

Future<List<Survey>> getAllSurvey({String apiStr = 'all_surveys_api'}) async {
  final String apiUrl = '${apiEndPoint}/${apiStr}?user_id=${usertype}';

  // Make a POST request to the API
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> parsed = json.decode(response.body);

    return parsed.map((json) => Survey.fromJson(json)).toList();
  } else {
    return [];
  }
}


Future<int> login(String email, String password) async {
  final String apiUrl = '${apiEndPoint}/login_post';

  // Create a JSON request body with email and password
  final Map<String, dynamic> requestBody = {
    'username': email,
    'password': password,
  };

  // Make a POST request to the API
  final response = await http.post(
    Uri.parse(apiUrl),
    body: requestBody,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    // Check the 'status' field in the response
    if (responseData['status'] == false) {
      // Login failed, return -1
      return -1;
    } else {
      updateLoginStatus(true);
      usertype = int.parse(responseData['id']);
      partnerId = int.parse(responseData['id']);

      updateLoginDetails(responseData['id'], responseData['name'], responseData['email']);
      return 1; // You can use any other code to represent success.
    }
  } else {
    // Handle API request errors here
    throw Exception('Failed to load data from the API');
  }
}

Future<int> createAccount(
    String referralCode,
    String name,
    String email,
    String password,
    String mobile,
    String city,
    String state,
    String partnerId,
    String usertype,
) async {
  final String apiUrl = '${apiEndPoint}/register';

  // Create a Map to represent the request data
  final Map<String, dynamic> jsonBody = {
    'referral': referralCode,
    'name': name,
    'email': email,
    'password': password,
    'mobile': mobile,
    'state': state,
    'city': city,
    'partnerid' : partnerId,
    'usertype': usertype, // Assuming usertype is a constant value
  };

  // Make a POST request to the API
  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonBody,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    // Check the 'success' field in the response
    if (responseData['success'] == false) {
      if (responseData['message'] == 'email already exist') {
        return 0;
      } else{
        return -1;
      }
    } else if(responseData['success'] == true) {
      return 1;
    } else{
      return -1;
    }
  } else {
    // Handle API request errors here
    throw Exception('Failed to create an account. Status code: ${response.statusCode}');
  }
}


Future<int> changePassword(String user_id, String password, String cpassword) async {
  final String apiUrl = '${apiEndPoint}/reset_password_api';

  // Create a JSON request body with user_id, password, and cpassword
  final Map<String, dynamic> requestBody = {
    'user_id': user_id,
    'password': password,
    'cpassword': cpassword,
  };

  // Make a POST request to the API
  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode(requestBody),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    // Check the 'status' field in the response
    if (responseData['status'] == 'error') {
      // Password change failed, return -1
      return -1;
    } else {
      // Password change was successful, return a success code (you can define your own)
      return 1; // You can use any other code to represent success.
    }
  } else {
    // Handle API request errors here
    throw Exception('Failed to update password.');
  }
}
