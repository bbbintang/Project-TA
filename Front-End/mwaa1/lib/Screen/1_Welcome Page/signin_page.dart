import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mwaa1/Screen/1_Welcome%20Page/signup_page.dart';
import 'package:mwaa1/Screen/2_Registrasi%20Page/regis_screen.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';
import 'package:flutter/cupertino.dart';

class AppAssets {
  static String kAppLogo = 'assets/LOGOaja.png';
  static String kGoogle = 'assets/google.png';
}

class AppColors {
  static const Color kPrimary = Colors.orange;
  static const Color kSecondary = Color(0xFF3F2D20);
  static const Color kBackground = Color(0xFFFFF5E0);
  static const Color kOrange = Colors.orange;
  static const Color kLine = Color(0xFFE6DCCD);
}

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _FoochiSignInViewState();
}

class _FoochiSignInViewState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isEmailCorrect = false;

  // Added Google Sign In functionality
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isGoogleSignInLoading = false;

  // Implement Google Sign In method
  Future<void> _signInWithGoogle() async {
    if (_isGoogleSignInLoading) return;
    setState(() {
      _isGoogleSignInLoading = true;
    });

    try {
      // Clear existing sessions
      await _googleSignIn.signOut();
      await _auth.signOut();

      // Start Google Sign In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'sign_in_canceled',
          message: 'Sign in was canceled by user.',
        );
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null && mounted) {
        // Navigate to registration screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisScreen(
              displayName: user.displayName ?? "User",
              email: user.email ?? "",
              photoUrl: user.photoURL ?? "",
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, 'Login gagal: ${e.message}');
    } catch (e) {
      _showErrorDialog(context, 'Terjadi kesalahan: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleSignInLoading = false;
        });
      }
    }
  }

  // Error dialog implementation
  void _showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: FadeAnimation(
            delay: 1,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.orange,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(AppAssets.kAppLogo, scale: 2.3),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Sign In',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kSecondary)),
                const SizedBox(height: 24),
                SocialIconRow(
                  // Updated callbacks
                  facebookCallback: () {
                    debugPrint('Facebook');
                  },
                  googleCallback: _signInWithGoogle, // Integrated Google Sign In
                  twitterCallback: () {
                    debugPrint('Twitter');
                  },
                ),
                const SizedBox(height: 30),
                const Text('Or with Email',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kSecondary)),
                const SizedBox(height: 23),
                AuthField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isFieldValidated: isEmailCorrect,
                  onChanged: (value) {
                    setState(() {});
                    isEmailCorrect = validateEmail(value);
                  },
                  hintText: 'Your Email',
                  validator: (value) {
                    if (!validateEmail(value!)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AuthField(
                  hintText: 'Your Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  isForgetButton: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    } else if (!RegExp(r'^(?=.[a-z])(?=.[A-Z])(?=.*\d).+$')
                        .hasMatch(value)) {
                      return 'Password should contain at least one uppercase letter, one lowercase letter, and one digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {}
                    },
                    text: 'Sign In'),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New User?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kSecondary,
                        )),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()),
                        );
                      },
                      text: 'Sign Up',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      return emailRegex.hasMatch(value);
    }
  }
}

// Remaining widget classes stay the same
class SocialIcons extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool isGoogleIcon;
  const SocialIcons(
      {Key? key,
      required this.onTap,
      required this.child,
      this.isGoogleIcon = false})
      : super(key: key);

  @override
  State<SocialIcons> createState() => _SocialIconsState();
}

class _SocialIconsState extends State<SocialIcons>
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
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.isGoogleIcon ? AppColors.kOrange : null,
              border: widget.isGoogleIcon
                  ? null
                  : Border.all(color: AppColors.kLine),
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class SocialIconRow extends StatelessWidget {
  final VoidCallback googleCallback;
  final VoidCallback facebookCallback;
  final VoidCallback twitterCallback;
  final bool isGoogleSignInLoading;

  const SocialIconRow(
      {super.key,
      required this.googleCallback,
      required this.facebookCallback,
      required this.twitterCallback,
      this.isGoogleSignInLoading = false,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SocialIcons(
                onTap: googleCallback,
                isGoogleIcon: true,
                child: isGoogleSignInLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.kGoogle),
                          const SizedBox(width: 10),
                          const Text(
                            'with Google',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        ],
                      ))),
      ],
    );
  }
}

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isFieldValidated;
  final bool isForgetButton;
  final bool isPasswordField;
  final bool isPhone;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.onChanged,
    this.isFieldValidated = false,
    this.validator,
    this.isPhone = false,
    this.isPasswordField = false,
    this.isForgetButton = false,
    this.keyboardType,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? isObscure : false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          errorMaxLines: 2,
          filled: false,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kLine),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),
          suffixIcon: widget.isForgetButton
              ? CustomTextButton(
                  onPressed: () {},
                  text: 'Forgot?',
                  color: AppColors.kPrimary,
                )
              : widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.kPrimary,
                      ),
                    )
                  : Icon(widget.isPhone ? Icons.phone_android : Icons.done,
                      size: 20,
                      color: widget.isFieldValidated
                          ? AppColors.kPrimary
                          : AppColors.kLine)),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text(
        text,
        style: TextStyle(color: color ?? AppColors.kPrimary, fontSize: 14),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  const PrimaryButton({
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
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.kPrimary,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.color == null ? Colors.black : Colors.white,
                fontSize: widget.fontSize ?? 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    // Definisikan MovieTween
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500))
      ..tween('translateY', Tween(begin: -30.0, end: 0.0),
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation
            .get<double>('opacity'), // Ambil opacity dengan tipe yang tepat
        child: Transform.translate(
          offset: Offset(
              0, animation.get<double>('translateY')), // Ambil translateY
          child: child,
        ),
      ),
    );
  }
}