import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  final int _animationDuration = 1;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: _animationDuration),
      vsync: this,
    );
    //animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.grey[900], end: Colors.white)
        .animate(controller);
    controller.forward();
    // animation?.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller?.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller?.forward();
    //   }
    // });
    controller.addListener(() {
      setState(() {});
      //print(animation?.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: Duration(milliseconds: 500),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Log In',
              onPress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Register',
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
