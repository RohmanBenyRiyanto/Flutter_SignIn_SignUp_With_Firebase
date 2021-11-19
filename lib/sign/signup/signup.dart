import 'package:autentic_apps/home.dart';
import 'package:autentic_apps/model/user_model.dart';
import 'package:autentic_apps/sign/signin/signin.dart';
import 'package:autentic_apps/theme/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  static String routeName = "/signup";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //firebase
  final _auth = FirebaseAuth.instance;
  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final usernameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  // string for displaying the error Message
  String? errorMessage;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 8, // <-- Use this
        centerTitle: false, // <-- and this
        backgroundColor: color_white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Text(
            "ahmedabad, gujarat ",
            style: GoogleFonts.dmSans(
              color: color_black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            icon: Icon(
              Icons.location_on_outlined,
              color: color_black,
              size: 21,
            ),
            onPressed: () {
              print('maps');
            }, //do something,
          ),
        ),
      ),
      backgroundColor: color_white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                height: 55.0,
                width: (MediaQuery.of(context).size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Getting Started',
                      style: GoogleFonts.dmSans(
                        color: color_black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Create an account to continue!',
                      style: GoogleFonts.dmSans(
                        color: color_tittle,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: GoogleFonts.dmSans(
                        color: color_tittle,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person_outlined,
                          size: 24,
                          color: color_black,
                        ),
                        hintText: 'Input your username',
                        hintStyle: GoogleFonts.dmSans(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        focusColor: color_black,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: color_grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: color_main),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("Username cannot be Empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid name(Min. 3 Character)");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usernameController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: GoogleFonts.dmSans(
                        color: color_tittle,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: color_black,
                        ),
                        hintText: 'Input your email',
                        hintStyle: GoogleFonts.dmSans(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        focusColor: color_black,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: color_grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: color_main),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }
                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usernameController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Password',
                      style: GoogleFonts.dmSans(
                        color: color_tittle,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    buildTextFieldpassword("Input your password"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          shape: CircleBorder(),
                          focusColor: color_blue,
                          activeColor: color_main,
                          value: isChecked,
                          onChanged: (newValue) {
                            setState(() => isChecked = newValue!);
                          }),
                      RichText(
                        text: TextSpan(
                          text: "By creating an account, you agree to our\n",
                          style: GoogleFonts.dmSans(
                              color: color_tittle,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()),
                                  );
                                  print('Pindah ke Sign In');
                                },
                              text: 'Term & Conditions',
                              style: GoogleFonts.dmSans(
                                  color: color_black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                height: 44.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    isChecked
                        ? signUp(emailController.text, passwordController.text)
                        : null;
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color_gradstar, color_gradend],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        constraints: BoxConstraints(minHeight: 44.0),
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              color: color_white,
                              size: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'SIGN UP',
                                  style: GoogleFonts.dmSans(
                                    color: color_white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: GoogleFonts.dmSans(
                      color: color_tittle,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );

                          print('Pindah ke Sign In');
                        },
                      text: 'Sign In',
                      style: GoogleFonts.dmSans(
                          color: color_black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                height: 44.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    signUp(emailController.text, passwordController.text);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: color_blue,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(minHeight: 44.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset('assets/svg/ic_facebook.svg'),
                          SizedBox(width: 10),
                          Text(
                            'Connect with Facebook',
                            style: GoogleFonts.dmSans(
                              color: color_white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldpassword(String hintText) {
    return TextFormField(
      autofocus: false,
      controller: passwordController,
      focusNode: _focusNodes[0],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.dmSans(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: color_grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: color_main),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: _focusNodes[0].hasFocus ? color_black : color_black,
        ),
        suffixIcon: hintText == "Input your password"
            ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                color: _focusNodes[0].hasFocus ? color_black : color_black,
              )
            : null,
      ),
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        usernameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      obscureText: hintText == "Input your password" ? _isHidden : false,
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = usernameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
