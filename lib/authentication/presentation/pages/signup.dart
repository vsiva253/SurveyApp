import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesurvey/authentication/data/repositories/users_repo.dart';
import 'package:thesurvey/authentication/presentation/pages/login.dart';
import 'package:thesurvey/authentication/presentation/pages/reset_password.dart';
import 'package:thesurvey/constants/colors.dart';
import 'package:thesurvey/constants/values.dart';
import 'package:thesurvey/pages/home_page.dart';

import '../../../utils/fonts.dart';
import '../../../utils/items.dart';
import '../../../utils/methods.dart';
import '../../../widgets/snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController referralController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController partnerIdController = TextEditingController();

  FocusNode _focusCityNode = FocusNode();
  FocusNode _focusStateNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String countryCode = "+91";
  bool keepSigned = true;

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
        } else if (!isNumeric(input) || input.length != 10) {
          return 'Invalid phone number';
        }
        break;

      case 4:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 5:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 6:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 7:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    getCity();
    getStates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        elevation: 0.5,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Create an Account',
                      style: MainFonts.pageTitleText(color: thirdColor)),
        ),
      ),
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
                Center(child: Image.asset(logoPath, height: 60,)),
                SizedBox(
                  height: 30,
                ),
              Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 0);
                        }),
                        controller: referralController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Referral Code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 1);
                        }),
                        controller: nameController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'John Doe',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 2);
                        }),
                        controller: emailController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'hello@example.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: ((value) {
                          return _validateInput(value, 3);
                        }),
                        style: TextStyle(fontSize: 18),
                        maxLength: 10,
                        decoration: InputDecoration(
                          prefixIcon: CountryCodePicker(
                            textStyle: TextStyle(fontSize: 18),
                            onChanged: ((value) {
                              countryCode = value.dialCode.toString();
                            }),
                            initialSelection: '+91',
                            favorite: ['+91', 'IND'],
                            showFlagDialog: true,
                            showFlagMain: false,
                            alignLeft: false,
                          ),
                          labelText: 'Mobile',
                          hintText: '1234567890',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: ((value) {
                          return _validateInput(value, 4);
                        }),
                        controller: passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == "") {
                            return Items.state;
                          }
                          return Items.state.where((String element) {
                            return element.toLowerCase().contains(
                                textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String item) {},
                        optionsViewBuilder: ((context, onSelected, options) {
                          return Material(
                            elevation: 6,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: (MediaQuery.of(context).size.width) -
                                      40,
                                  height: 450,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(6),
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final String option =
                                          options.elementAt(index);

                                      return InkWell(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option,
                                              style:
                                                  MainFonts.suggestionText()),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          stateController = textEditingController;
                          _focusStateNode = focusNode;
                          return TextFormField(
                            keyboardType: TextInputType.text,
                        validator: ((value) {
                          return _validateInput(value, 6);
                        }),
                        controller: stateController,
                        focusNode: _focusStateNode,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'State',
                          hintText: 'Delhi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                        },
                      ),
                      SizedBox(height: 20),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == "") {
                            return Items.citys;
                          }
                          return Items.state.where((String element) {
                            return element.toLowerCase().contains(
                                textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String item) {},
                        optionsViewBuilder: ((context, onSelected, options) {
                          return Material(
                            elevation: 6,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: (MediaQuery.of(context).size.width) -
                                      40,
                                  height: 450,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(6),
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final String option =
                                          options.elementAt(index);

                                      return InkWell(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option,
                                              style:
                                                  MainFonts.suggestionText()),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          cityController = textEditingController;
                          _focusCityNode = focusNode;
                          return TextFormField(
                            validator: ((value) {
                              return _validateInput(value, 5);
                            }),
                            focusNode: _focusCityNode,
                            controller: cityController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: 'City',
                              hintText: 'Delhi',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text('By continuing, you agree to our ',
                                style: MainFonts.hintFieldText(fontSize: 16)),
                          ),
                          Flexible(
                            child: Text('terms of service.',
                                style: MainFonts.hintFieldText(
                                    color: fourthColor, fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                              bool isValid =
                                  _formKey.currentState!.validate();
                              if (isValid) {
                                int result = await createAccount(
                                    referralController.text,
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    (countryCode + mobileController.text).substring(1),
                                    cityController.text,
                                    stateController.text,
                                    partnerId.toString(),
                                    usertype.toString());
                                if (result == 1) {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                          mySnackBarShow(context,
                                      'Account created successfully!');
                                } else if(result == 0) {
                                  mySnackBarShow(context,
                                      'Email address already in use! Try another');
                                } else {
                                  mySnackBarShow(context,
                                      'Something went wrong! Try again');
                                }
                              }
                            },
                            child: Text('Sign Up',
                                style: AuthFonts.authButtonText(
                                    color: primaryColor))),
                      )
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            textAlign: TextAlign.center,
                            style: MainFonts.hintFieldText()),
                        Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: MainFonts.lableText(color: secondaryColor),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
