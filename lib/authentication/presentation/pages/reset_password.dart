import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesurvey/authentication/data/repositories/users_repo.dart';
import 'package:thesurvey/authentication/presentation/pages/signup.dart';
import 'package:thesurvey/constants/colors.dart';
import 'package:thesurvey/pages/home_page.dart';
import '../../../constants/values.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/snackbar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool keepSigned = true;

  bool _obscureText1 = true;
  bool _passwordVisible1 = true;

  bool _obscureText2 = true;
  bool _passwordVisible2 = true;

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
                Text('Reset Password?', style: MainFonts.pageTitleText(color: thirdColor)),
                SizedBox(
                  height: 20,
                ),
                Text('Enter your new password twice below to reset a new password.', style: MainFonts.hintFieldText(), textAlign: TextAlign.start),
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
                          controller: password1Controller,
                          obscureText: _obscureText1,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible1 = !_passwordVisible1;
                                    _obscureText1 = !_obscureText1;
                                  });
                                },
                                icon: Icon(_passwordVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          validator: ((value) {
                            return _validateInput(value, 1);
                          }),
                          controller: password2Controller,
                          obscureText: _obscureText2,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Re-enter new password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible2 = !_passwordVisible2;
                                    _obscureText2 = !_obscureText2;
                                  });
                                },
                                icon: Icon(_passwordVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
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
                              onPressed: () async{
                                bool isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  int result = await changePassword(widget.email, password1Controller.text, password2Controller.text);
                                  if(result == 1) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                  } else{
                                    mySnackBarShow(context, 'Something went wrong! Try again');
                                  }
                                }
                              },
                              child: Text('Reset Password',
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
