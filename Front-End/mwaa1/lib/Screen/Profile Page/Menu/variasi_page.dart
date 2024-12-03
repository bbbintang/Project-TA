import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VariasiPage extends StatefulWidget {
  const VariasiPage({super.key});

  @override
  State<VariasiPage> createState() => _VariasiPageState();
}

class _VariasiPageState extends State<VariasiPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? selectedValue;
  String? pilihanValue;
  var isChecked = false;
  bool _isObscure = true;

Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Pengguna membatalkan login
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? enteredPassword;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            "assets/LOGOaja.png",
            color: Colors.orange,
            height: 100,
            width: 100,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Variasi",
                  style: poppin20bold.copyWith(
                      color: Colors.black87, letterSpacing: 1.0, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 16, right: 16, bottom: 10),
                child: Text(
                  "Jenis Udang",
                  style: poppin15normal.copyWith(
                      color: Colors.black, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String?>(
                  value: selectedValue,
                  items: ["Vaname", "Udang Galah", "Udang Windu"]
                      .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: Text("Pilih Jenis Udang"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 16, right: 16, bottom: 16),
                child: Text(
                  'Jenis Tambak',
                  style: poppin15normal.copyWith(
                      color: Colors.black, fontSize: 17),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String?>(
                  value: pilihanValue,
                  items: [
                    "Tradisional",
                    "Intensif",
                    "Super Intensif"
                  ]
                      .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onChanged: (nilai) {
                    setState(() {
                      pilihanValue = nilai;
                    });
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: const Text("Pilih Jenis Tambak"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: Colors.orange[300],
                    ),
                    Text(
                      "Pengaturan Sudah Sesuai",
                      style: poppin15normal.copyWith(color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 16, right: 16, bottom: 16),
                child: Text(
                  'Kata Sandi',
                  style: poppin15normal.copyWith(
                      color: Colors.black, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: TextField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  children: [
                    SizedBox(
                      width: 230,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(80, 30),
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            backgroundColor: bluelogin),
                        child: Text(
                          "Selesai",
                          style: outfit15normal.copyWith(color: Colors.white),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
