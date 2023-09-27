// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth/loginScreen.dart';
import 'auth/signUpScreen.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  String action = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.red.withOpacity(0.1),
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundflu.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/nai.png', width: 250, height: 250),
                Text(
                  'hoşgeldiniz',
                  style: GoogleFonts.indieFlower(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'gelişmeler için bizi takip edin',
                        style: GoogleFonts.indieFlower(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            GetWebSayfasi(0);
                          },
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            GetWebSayfasi(1);
                          },
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            GetWebSayfasi(2);
                          },
                          icon: Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            GetWebSayfasi(3);
                          },
                          icon: Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blue[800],
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'bir hesabınız varsa giriş yapın veya bizimle birlikte olmak için yeni hesap oluşturun',
                      style: GoogleFonts.indieFlower(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width > 500
                                ? MediaQuery.of(context).size.width / 3.3
                                : MediaQuery.of(context).size.width / 5,
                            vertical: 25)
                        // padding: EdgeInsets.only(
                        //     left: 120, right: 120, top: 20, bottom: 20),
                        ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftPop,
                              child: loginScreen(),
                              childCurrent: welcomeScreen()));
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => loginScreen()));
                    },
                    child: Text(
                      'giriş sayfasına yönlendir',
                      style: GoogleFonts.indieFlower(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'hesabınız yok mu ?',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    signUpScreen()));
                      },
                      child: Text(
                        'hesap oluştur',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> GetWebSayfasi(int type) async {
    try {
      // insta
      if (type == 0) {
        final Uri url = Uri.parse('https://www.instagram.com/umtbrdk/');

        await launchUrl(url);
      }
      // facebook
      if (type == 1) {
        final Uri url = Uri.parse('https://www.instagram.com/umtbrdk/');

        await launchUrl(url);
      } // twitter
      if (type == 2) {
        final Uri url = Uri.parse('https://www.instagram.com/umtbrdk/');

        await launchUrl(url);
      } // linkedin
      if (type == 3) {
        final Uri url = Uri.parse('https://tr.linkedin.com/in/umtbrdk');

        await launchUrl(url);
      }
    } catch (e) {}
  }
}
