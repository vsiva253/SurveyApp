import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesurvey/authentication/presentation/pages/reset_password.dart';
import 'package:thesurvey/authentication/presentation/pages/signup.dart';
import 'package:thesurvey/constants/colors.dart';

import '../../../constants/values.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/snackbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool keepSigned = true;

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

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(logoPath, height: 120,)),
                SizedBox(
                  height: 16,
                ),
                Text('Forgot Password?', style: MainFonts.pageTitleText(color: thirdColor)),
                SizedBox(
                  height: 20,
                ),
                Text('Enter your email address to get the password reset link.', style: MainFonts.hintFieldText(), textAlign: TextAlign.start),
                SizedBox(
                  height: 40,
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                bool isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPassword(email: emailController.text,)));
                                }
                              },
                              child: Text('Password Reset',
                                  style: AuthFonts.authButtonText(color: primaryColor))),
                        )
                      ]),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    child: Text('Create an account', textAlign: TextAlign.center, style: MainFonts.lableText(color: secondaryColor),)))
              ],
            ),
          ),
        ));
  }
}
