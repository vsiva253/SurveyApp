import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:thesurvey/constants/colors.dart';
import 'package:thesurvey/utils/fonts.dart';
import 'package:intl/intl.dart';
import 'package:thesurvey/widgets/snackbar.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _passwordVisible = true;

  String? _validateInput(String? input, int index) {
    if (input != null) {
      input = input.trim();
    }

    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 2:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;
      
      case 3:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length != 10) {
          return 'Invalid Date';
        }
        break;
      
      case 4:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: Center(
            child: Container(
              margin: EdgeInsets.only(right: 56),
              child: Text(
                      'Profile Info',
                      textAlign: TextAlign.center,
                    ),
            )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'),
                radius: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Hello Traveler',
                style: MainFonts.lableText(),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 0);
                        }),
                        controller: nameController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name here',
                          hintStyle: MainFonts.hintFieldText(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 1);
                        }),
                        controller: emailController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Address',
                          hintText: 'Enter your address',
                          hintStyle: MainFonts.hintFieldText(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 2);
                        }),
                        controller: passportController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Passport',
                          hintText: 'ED 25265 589',
                          hintStyle: MainFonts.hintFieldText(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 3);
                        }),
                        controller: dobController,
                        style: TextStyle(fontSize: 18),
                        onTap: () {
                          _selectDate();
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_month),
                            onPressed: () async {
                              _selectDate();
                            },
                          ),
                          labelText: 'DOB',
                          hintText: '12/05/1990',
                          hintStyle: MainFonts.hintFieldText(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 4);
                        }),
                        controller: countryController,
                        style: TextStyle(fontSize: 18),
                        onTap: () {
                          _selectCountry();
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.keyboard_arrow_down),
                            onPressed: () async {
                              _selectCountry();
                            },
                          ),
                          labelText: 'Country',
                          hintText: 'Country',
                          hintStyle: MainFonts.hintFieldText(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () async {
                              bool isValid = _formKey.currentState!.validate();
                              if (isValid) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Confirm',
                                style: AuthFonts.authButtonText(
                                    color: primaryColor))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Skip',
                              textAlign: TextAlign.center,
                              style: MainFonts.lableText(color: secondaryColor),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _selectDate() async{
    DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      1900), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2040));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dobController.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                mySnackBarShow(context, 'Please select date');
                              }
  }

  _selectCountry() {
    showCountryPicker(
  context: context,
  favorite: ['IN'],
  showPhoneCode: true, // optional. Shows phone code before the country name.
  onSelect: (Country country) {
    countryController.text = country.displayName;
  },
);
  }
}
