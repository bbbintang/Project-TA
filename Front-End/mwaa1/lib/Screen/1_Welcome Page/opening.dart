import 'package:animate_do/animate_do.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwaa1/Screen/1_Welcome%20Page/signin_page.dart';

class AppAssets {
  static String kOnboardingFirst = 'assets/11.png';
  static String kOnboardingSecond = 'assets/12.png';
  static String kOnboardingThird = 'assets/15.png';
}

class AppColors {
  static const Color kPrimary = Colors.black;
  static const Color kSecondary = Colors.black;
  static const Color kBackground = Colors.orange;
}

class Opening extends StatefulWidget {
  const Opening({super.key});

  @override
  State<Opening> createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: onboardingList.length,
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return OnBoardingCard(
                    index: index,
                    onBoarding: onboardingList[index],
                  );
                },
              ),
            ),
            CustomIndicator(position: currentIndex),
            const SizedBox(height: 83),
            CustomOutlinedButton(
              width: 130,
              onTap: () {
                if (currentIndex == (onboardingList.length - 1)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              text: currentIndex == (onboardingList.length - 1)
                  ? 'Get Started'
                  : 'Next',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  const CustomOutlinedButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(color: widget.color ?? AppColors.kPrimary),
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? 20,
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: widget.color ?? AppColors.kPrimary,
                  fontSize: widget.fontSize ?? 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class Onboarding {
  String title1;
  String title2;
  String description;
  String image;
  Onboarding({
    required this.title1,
    required this.title2,
    required this.description,
    required this.image,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
      title1: 'Monitoring ',
      title2: 'Warning and Action',
      description:
          'Introducing a water quality monitoring application for shrimp ponds',
      image: AppAssets.kOnboardingFirst),
  Onboarding(
      title1: 'Manage ',
      title2: 'Your Pond Easily',
      description:
          'With IoT, You can monitor your water quality with sensors remotely.',
      image: AppAssets.kOnboardingSecond),
  Onboarding(
      title1: 'Let\'s ',
      title2: 'Get Started',
      description: 'Take care of your shrimp now!',
      image: AppAssets.kOnboardingThird)
];

class CustomIndicator extends StatelessWidget {
  final int position;
  const CustomIndicator({required this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: onboardingList.length,
      position: position,
      decorator: DotsDecorator(
        color: Colors.grey.withOpacity(0.5),
        size: const Size.square(8.0),
        activeSize: const Size(20.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        activeColor: AppColors.kPrimary,
      ),
    );
  }
}

class OnBoardingCard extends StatelessWidget {
  final Onboarding onBoarding;
  final int index;
  const OnBoardingCard({
    required this.onBoarding,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(onBoarding.image),
                fit: BoxFit.cover,
                scale: 1.5)),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: onBoarding.title1,
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: AppColors.kSecondary),
                  children: [
                    TextSpan(
                      text: onBoarding.title2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 36),
                    )
                  ]),
            ),
            const SizedBox(height: 20),
            Text(
              onBoarding.description,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
