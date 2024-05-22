import 'package:ash_personal_assistant/utils/custom_button.dart';
import 'package:ash_personal_assistant/utils/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ash_personal_assistant/theme/colors.dart';
import 'package:ash_personal_assistant/theme/font_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ash_personal_assistant/services/auth.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int fadeDuration = 300;
  int scaleDuration = 400;
  Curve cv = Curves.ease;

  String _currentState = "onboarding";
  bool _allFadeOut = false;
  bool _allowResize = false;
  double _currentSize = 490;

  final signupEmail = TextEditingController();
  final signupPassword = TextEditingController();
  final signupPasswordAgain = TextEditingController();

  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();

  double getSizeFromState() {
    if (_allowResize == false) {
      return _currentSize;
    }

    if (_currentState == "login") {
      _currentSize = 555;
      return 555;
    } else if (_currentState == "signup") {
      _currentSize = 617.25;
      return 617.25;
    } else {
      _currentSize = 490;
      return 490;
    }
  }

  double getOpacityFromState(String state) {
    if (state == _currentState && _allFadeOut == false) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void dispose() {
    signupEmail.dispose();
    signupPassword.dispose();
    signupPasswordAgain.dispose();
    loginEmail.dispose();
    loginPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const ColorPalette().night,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(50)),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              //Related to: card - size
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AnimatedContainer(
                      onEnd: () => setState(() {
                        _allFadeOut = false;
                        _allowResize = false;
                      }),
                      curve: cv,
                      duration: Duration(milliseconds: scaleDuration),
                      width: 382,
                      height: getSizeFromState(),
                      child: Image.asset(
                        "assets/images/onboarding_gradient_background.png",
                        width: 382,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //Related to: card - onboarding - outside
                  AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    switchInCurve: cv,
                    switchOutCurve: cv,
                    duration: Duration(milliseconds: fadeDuration),
                    child: getOpacityFromState("onboarding") == 1
                        ? Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(15)),
                              Center(
                                child: CustomButton(
                                  height: 75,
                                  width: 382,
                                  cornerRadius: 10,
                                  backgroundColor:
                                      const ColorPalette().mintCream,
                                  onTap: () => setState(() {
                                    _currentState = "login";
                                    _allFadeOut = true;
                                    _allowResize = false;
                                  }),
                                  child: Text(
                                    "Log in",
                                    textAlign: TextAlign.center,
                                    style: defaultFontStyle(FontWeight.w800,
                                        const ColorPalette().night, 24),
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(13)),
                              RichText(
                                text: TextSpan(
                                  style: defaultFontStyle(FontWeight.w300,
                                      const ColorPalette().mintCream, 17),
                                  children: [
                                    const TextSpan(
                                        text: "Don’t have an account? "),
                                    TextSpan(
                                      text: "Sign up",
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => setState(() {
                                              _currentState = "signup";
                                              _allFadeOut = true;
                                              _allowResize = false;
                                            }),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(30)),
                              Text(
                                "Created by Daniel Sarfraz",
                                style: defaultFontStyle(),
                              ),
                              Text(
                                "Version 0.1.0",
                                style: defaultFontStyle(FontWeight.w300,
                                    const ColorPalette().mintCream, 11),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  //Related to: card - login - outside
                  AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    switchInCurve: cv,
                    switchOutCurve: cv,
                    duration: Duration(milliseconds: fadeDuration),
                    child: getOpacityFromState("login") == 1
                        ? Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(18)),
                              RichText(
                                text: TextSpan(
                                  style: defaultFontStyle(FontWeight.w300,
                                      const ColorPalette().mintCream, 17),
                                  children: [
                                    const TextSpan(
                                        text: "Don’t have an account? "),
                                    TextSpan(
                                      text: "Sign up",
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => setState(() {
                                              _currentState = "signup";
                                              _allFadeOut = true;
                                              _allowResize = false;
                                            }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  //Related to: card - signup - outside
                  AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    switchInCurve: cv,
                    switchOutCurve: cv,
                    duration: Duration(milliseconds: fadeDuration),
                    child: getOpacityFromState("signup") == 1
                        ? Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(18)),
                              RichText(
                                text: TextSpan(
                                  style: defaultFontStyle(FontWeight.w300,
                                      const ColorPalette().mintCream, 17),
                                  children: [
                                    const TextSpan(
                                        text: "Already have an account? "),
                                    TextSpan(
                                      text: "Log in",
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => setState(() {
                                              _currentState = "login";
                                              _allFadeOut = true;
                                              _allowResize = false;
                                            }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
              //Related to: card - onboarding - contents
              IgnorePointer(
                ignoring: getOpacityFromState("onboarding") == 1 ? false : true,
                child: AnimatedOpacity(
                  curve: cv,
                  onEnd: () => setState(() {
                    if (_currentState != "onboarding") {
                      _allowResize = true;
                    }
                  }),
                  opacity: getOpacityFromState("onboarding"),
                  duration: Duration(milliseconds: fadeDuration),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(52)),
                      SizedBox(
                        width: 382,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 382 / 2,
                            child: Text(
                              "Hi, I’m",
                              textAlign: TextAlign.center,
                              style: defaultFontStyle(FontWeight.w400,
                                  const ColorPalette().mintCream, 38),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/ash_text_animation.gif",
                        width: 260,
                      ),
                      const Padding(padding: EdgeInsets.all(26)),
                      Text(
                        "Your personal AI Assistant",
                        style: defaultFontStyle(FontWeight.w300,
                            const ColorPalette().mintCream, 22),
                      ),
                    ],
                  ),
                ),
              ),
              //Related to: card - signup - contents
              IgnorePointer(
                ignoring: getOpacityFromState("signup") == 1 ? false : true,
                child: AnimatedOpacity(
                  curve: cv,
                  onEnd: () => setState(() {
                    if (_currentState != "signup") {
                      _allowResize = true;
                    }
                  }),
                  opacity: getOpacityFromState("signup"),
                  duration: Duration(milliseconds: fadeDuration),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(42)),
                      Text(
                        "Welcome to Ash!",
                        textAlign: TextAlign.center,
                        style: defaultFontStyle(FontWeight.w500,
                            const ColorPalette().mintCream, 28.5),
                      ),
                      const Padding(padding: EdgeInsets.all(24)),
                      CustomTextField(
                        controller: signupEmail,
                        height: 56.25,
                        width: 303,
                        fontSize: 18,
                        cornerRadius: 7.5,
                        textColor: const ColorPalette().night,
                        borderColor: const ColorPalette().night,
                        borderWidth: 1.5,
                        focusBorderColor: const ColorPalette().night,
                        focusBorderWidth: 2,
                        backgroundColor: const ColorPalette().mintCream,
                        hintText: "Email",
                        obscureText: false,
                      ),
                      const Padding(padding: EdgeInsets.all(6)),
                      CustomTextField(
                        controller: signupPassword,
                        height: 56.25,
                        width: 303,
                        fontSize: 18,
                        cornerRadius: 7.5,
                        textColor: const ColorPalette().night,
                        borderColor: const ColorPalette().night,
                        borderWidth: 1.5,
                        focusBorderColor: const ColorPalette().night,
                        focusBorderWidth: 2,
                        backgroundColor: const ColorPalette().mintCream,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const Padding(padding: EdgeInsets.all(6)),
                      CustomTextField(
                        controller: signupPasswordAgain,
                        height: 56.25,
                        width: 303,
                        fontSize: 18,
                        cornerRadius: 7.5,
                        textColor: const ColorPalette().night,
                        borderColor: const ColorPalette().night,
                        borderWidth: 1.5,
                        focusBorderColor: const ColorPalette().night,
                        focusBorderWidth: 2,
                        backgroundColor: const ColorPalette().mintCream,
                        hintText: "Password Again",
                        obscureText: true,
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      CustomButton(
                        height: 56.25,
                        width: 303,
                        cornerRadius: 7.5,
                        backgroundColor: const ColorPalette().mintCream,
                        onTap: () {
                          if (signupPassword.text == signupPasswordAgain.text) {
                            Auth().createUserWithEmailAndPassword(
                              email: signupEmail.text,
                              password: signupPassword.text,
                              context: context,
                            );
                          }
                        },
                        child: Text(
                          "Sign up",
                          textAlign: TextAlign.center,
                          style: defaultFontStyle(
                              FontWeight.w700, const ColorPalette().night, 18),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 80,
                              indent: 55,
                              endIndent: 15,
                              color: const ColorPalette().mintCream,
                            ),
                          ),
                          Text(
                            "OR",
                            style: defaultFontStyle(FontWeight.w300,
                                const ColorPalette().mintCream, 14),
                          ),
                          Expanded(
                            child: Divider(
                              height: 80,
                              indent: 15,
                              endIndent: 55,
                              color: const ColorPalette().mintCream,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: 382,
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            CustomButton(
                              height: 50,
                              width: 50,
                              cornerRadius: 50,
                              backgroundColor: const ColorPalette().mintCream,
                              onTap: Auth().googleSignin,
                              child: SvgPicture.asset(
                                "assets/logos/google_logo.svg",
                                height: 47,
                                width: 47,
                              ),
                            ),
                            Expanded(child: Container()),
                            CustomButton(
                              height: 50,
                              width: 50,
                              cornerRadius: 50,
                              backgroundColor: const ColorPalette().mintCream,
                              onTap: Auth().microsoftSignin,
                              child: SvgPicture.asset(
                                "assets/logos/microsoft_logo.svg",
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Expanded(child: Container()),
                            CustomButton(
                              height: 50,
                              width: 50,
                              cornerRadius: 50,
                              backgroundColor: const ColorPalette().mintCream,
                              onTap: Auth().githubSignin,
                              child: SvgPicture.asset(
                                "assets/logos/github_logo.svg",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Related to: card - login - contents
              IgnorePointer(
                ignoring: getOpacityFromState("login") == 1 ? false : true,
                child: AnimatedOpacity(
                  curve: cv,
                  onEnd: () => setState(() {
                    if (_currentState != "login") {
                      _allowResize = true;
                    }
                  }),
                  opacity: getOpacityFromState("login"),
                  duration: Duration(milliseconds: fadeDuration),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(42)),
                      Text(
                        "Good to see you again!",
                        textAlign: TextAlign.center,
                        style: defaultFontStyle(FontWeight.w500,
                            const ColorPalette().mintCream, 28.5),
                      ),
                      const Padding(padding: EdgeInsets.all(24)),
                      CustomTextField(
                        controller: loginEmail,
                        height: 56.25,
                        width: 303,
                        fontSize: 18,
                        cornerRadius: 7.5,
                        textColor: const ColorPalette().night,
                        borderColor: const ColorPalette().night,
                        borderWidth: 1.5,
                        focusBorderColor: const ColorPalette().night,
                        focusBorderWidth: 2,
                        backgroundColor: const ColorPalette().mintCream,
                        hintText: "Email",
                        obscureText: false,
                      ),
                      const Padding(padding: EdgeInsets.all(6)),
                      CustomTextField(
                        controller: loginPassword,
                        height: 56.25,
                        width: 303,
                        fontSize: 18,
                        cornerRadius: 7.5,
                        textColor: const ColorPalette().night,
                        borderColor: const ColorPalette().night,
                        borderWidth: 1.5,
                        focusBorderColor: const ColorPalette().night,
                        focusBorderWidth: 2,
                        backgroundColor: const ColorPalette().mintCream,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      CustomButton(
                        height: 56.25,
                        width: 303,
                        cornerRadius: 7.5,
                        backgroundColor: const ColorPalette().mintCream,
                        onTap: () {
                          Auth().signInWithEmailAndPassword(
                            email: loginEmail.text,
                            password: loginPassword.text,
                            context: context,
                          );
                        },
                        child: Text(
                          "Log in",
                          textAlign: TextAlign.center,
                          style: defaultFontStyle(
                              FontWeight.w700, const ColorPalette().night, 18),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 80,
                              indent: 55,
                              endIndent: 15,
                              color: const ColorPalette().mintCream,
                            ),
                          ),
                          Text(
                            "OR",
                            style: defaultFontStyle(FontWeight.w300,
                                const ColorPalette().mintCream, 14),
                          ),
                          Expanded(
                            child: Divider(
                              height: 80,
                              indent: 15,
                              endIndent: 55,
                              color: const ColorPalette().mintCream,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: 382,
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            CustomButton(
                              height: 50,
                              width: 50,
                              cornerRadius: 50,
                              backgroundColor: const ColorPalette().mintCream,
                              onTap: Auth().googleSignin,
                              child: SvgPicture.asset(
                                "assets/logos/google_logo.svg",
                                height: 47,
                                width: 47,
                              ),
                            ),
                            Expanded(child: Container()),
                            CustomButton(
                              height: 50,
                              width: 50,
                              cornerRadius: 50,
                              backgroundColor: const ColorPalette().mintCream,
                              onTap: Auth().microsoftSignin,
                              child: SvgPicture.asset(
                                "assets/logos/microsoft_logo.svg",
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Expanded(child: Container()),
                            CustomButton(
                              height: 50,
                              width: 50,
                              cornerRadius: 50,
                              backgroundColor: const ColorPalette().mintCream,
                              onTap: Auth().githubSignin,
                              child: SvgPicture.asset(
                                "assets/logos/github_logo.svg",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
