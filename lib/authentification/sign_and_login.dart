import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  // bool isMale = true;
  bool isRememberMe = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
   String name = "";
   String pwd = "";
   String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFFb60036),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Bienvenue ",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? "Sur Allo Thieb," : "...",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Identifiez vous pour Continuer"
                          : "Enregistrez vous pour Continuer",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
          // Positioned(
          //   top: MediaQuery.of(context).size.height - 100,
          //   right: 0,
          //   left: 0,
          //   child: Column(
          //     children: [
          //       Text(isSignupScreen ? "Or Signup with" : "Or Signin with"),
          //       Container(
          //         margin: EdgeInsets.only(right: 20, left: 20, top: 15),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             buildTextButton(EvaIcons.facebook,
          //                 "Facebook", Palette.facebookColor),
          //             buildTextButton(EvaIcons.googleOutline,
          //                 "Google", Palette.googleColor),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(EvaIcons.person, "Axel124", false, true,
              nameController,name),
          SizedBox(height: 10,),
          buildTextField(
              EvaIcons.lockOutline, "**********", true, false,
              pwdController,pwd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: TextButton(
                  onPressed: (){},
                  child: Text("Mot de passe oublié?",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1)),
                )
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(EvaIcons.person, "Nom Utilisateur",
              false, false,nameController,name),
          SizedBox(height: 10,),
          buildTextField(
              EvaIcons.emailOutline, "email", false, true,
              emailController,email),
          SizedBox(height: 10,),
          buildTextField(
              EvaIcons.lockOutline, "Mot de passe", true, false,
              pwdController,pwd),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Avant de valider rassurez-vous vos données ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "sont correcte",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? OnHoverButton(

                child: GestureDetector(
            onTap: ()=>Navigator.pushReplacementNamed(context, '/mainscreen'),
                  child: Container(
            decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange.shade200, Colors.red.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ]),
            child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
            ),
          ),
                ),
              )
              : Center(),
        ),
      ),
    );
  }

  TextField buildTextField(
      IconData icon,
      String hintText,
      bool isPassword,
      bool isEmail,
      TextEditingController controller,
      onChanged,
      ) {
    return TextField(
        controller: controller,
        onChanged: (value) => setState(() => onChanged = value),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
      );

  }
}