import 'package:flutter/material.dart';
import 'package:help_buddy/resourcesScreen/ResourceScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_buddy/secondScreen/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

// First Commit

class _SecondScreenState extends State<SecondScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
    var auth = FirebaseAuth.instance;
    auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        print("user is logged in");
        //navigate to home page using Navigator Widget
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => MyResourcePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 40),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Cardo',
                            fontSize: 35,
                            color: Color(0xff0C2551),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        //
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, top: 5),
                        child: Text(
                          'Sign in with',
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 30,
                    ),
                    //
                    Container(
                      margin: EdgeInsets.only(left: 38),
                      child: Row(
                        children: [
                          Neu_button(
                            char: 'G',
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Neu_button(
                            char: 'f',
                          )
                        ],
                      ),
                    ),
                    //

                    SizedBox(
                      height: 30,
                    ),
                    //
                    // MyCustomInputBox(
                    //   label: 'Name',
                    //   inputHint: 'John',
                    // ),
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 50.0),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 50.0),
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //
                    Text(
                      "Signing in with your account means you're okay with\nour Terms of Service and Privacy Policy",
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8f9db5).withOpacity(0.75),
                      ),
                      //
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: RoundedButton(
                        text: "Log in",
                        fontSize: 20,
                        press: () async {
                          setState(() {
                            showSpinner=true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => MyResourcePage()));
                            }
                            setState(() {
                              showSpinner=false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Dont have an account? ',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff8f9db5).withOpacity(0.45),
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff90b7ff),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ClipPath(
                  clipper: OuterClippedPart(),
                  child: Container(
                    color: Color(0xff0962ff),
                    width: scrWidth,
                    height: scrHeight,
                  ),
                ),
                //
                ClipPath(
                  clipper: InnerClippedPart(),
                  child: Container(
                    color: Color(0xff0c2551),
                    width: scrWidth,
                    height: scrHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Neu_button extends StatelessWidget {
  Neu_button({this.char});
  String char;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Color(0xffaaaaaa).withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Color(0xff0962FF),
          ),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
