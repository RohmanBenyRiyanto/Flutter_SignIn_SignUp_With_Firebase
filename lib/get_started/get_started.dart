import 'package:autentic_apps/sign/signin/signin.dart';
import 'package:autentic_apps/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class Onboarding extends StatelessWidget {
  static String routeName = "/onboarding";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/big_oval.png',
                height: 350,
              ),
            ),
            Positioned(
              top: 200,
              child: Image.asset(
                'assets/images/small_oval.png',
                height: 200,
              ),
            ),
            Positioned(
              top: 45.0,
              right: 24.0,
              left: 24.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/kursi.png',
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Welcome to QuStore !',
                        style: GoogleFonts.dmSans(
                          color: color_black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'With long experience in the audio industry,\nwe create the best quality products',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          color: color_tittle,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.0),
                        height: 44.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
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
                                        'GET STARTED',
                                        style: GoogleFonts.dmSans(
                                          color: color_white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
