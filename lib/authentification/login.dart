import 'package:flutter/material.dart';


import '../app_colors.dart';
import '../constants.dart';
import '../custom_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFffaf00),
                Color(0xFFb60036),
              ])),
            ),
            Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.food_bank_rounded,color: white,size: 50,),
                  CustomText(
                      text: "Allo Thieb",
                      size: 20,
                      color: white),
                  SizedBox(height: defaultPadding,),
                  Center(
                      child: LoginForm(),
                    ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),

              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 3), blurRadius: 24)
              ]),
          height: 400,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "LOGIN", size: 22, weight: FontWeight.bold, color: SideMenuColor,),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200]
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left:8.0),
                    child: TextField(
                      // controller: authProvider.email,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: SideMenuColor),
                          icon: Icon(Icons.email_outlined,color: SideMenuColor,)
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: TextField(
                      // controller: authProvider.password,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: SideMenuColor),
                          icon: Icon(Icons.lock_open,color: SideMenuColor)
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.only(right:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(text: "Forgot password?", size: 16,color: Colors.grey, weight: FontWeight.normal,),
                  ],
                ),
              ),

              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Container(
                  decoration: BoxDecoration(
                      color: SideMenuColor,
                  ),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/MainScreen');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:4),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: "LOGIN", size: 22, color: Colors.white, weight: FontWeight.bold,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}
