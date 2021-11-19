import 'package:autentic_apps/get_started/get_started.dart';
import 'package:autentic_apps/home.dart';
import 'package:autentic_apps/sign/signin/signin.dart';
import 'package:autentic_apps/sign/signup/signup.dart';
import 'package:flutter/widgets.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Onboarding.routeName: (context) => Onboarding(),
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  Home.routeName: (context) => Home(),
};
