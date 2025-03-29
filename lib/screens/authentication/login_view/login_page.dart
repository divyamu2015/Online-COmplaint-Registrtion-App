import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home_page.dart';
import '../login_service/login_service.dart';
import '../sign_up_view/signin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    //  required this.userId
  });
  //final int? userId;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? userId;
  bool isLoading = false;
  String? role;

  @override
  void initState() {
    super.initState();
    // userId = widget.userId!;
    print('My LoginPage========$userId');
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    String userEmail = emailController.text.trim();
    String userPass = passController.text.trim();
    String userRole = "user";

    if (userEmail.isEmpty || userPass.isEmpty) {
      showError("Please enter email and password.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await loginUser(
        password: userPass,
        email: userEmail,
        role: userRole,
        id: 0, // Placeholder, API returns actual ID
      );

      if (response.message == "User Login successful") {
        emailController.clear();
        passController.clear();
        userId = response.id; // ✅ No need to check for null

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id', userId!);
        print("User ID stored in SharedPreferences: $userId");
        if (mounted) {
          showSuccess('Login successful!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userId: userId!,
              ),
            ),
          );
        }
      } else {
        showError("Error logging in. Please try again.");
      }
    } catch (e) {
      showError('Network Error: ${e.toString()}');
      print('Exception caught: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/12325319_4952521.jpg"),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 149, 170, 211),
              Colors.white,
              Color.fromARGB(255, 159, 176, 207),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                // width: 400,
                // height: 700,
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Online Complaint',
                        style: TextStyle(
                            color: Color.fromARGB(255, 21, 62, 116),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 25, 26),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.basic,
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter this field';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 15.0),
                                decoration: InputDecoration(
                                  // fillColor: Colors.white,
                                  hintText: 'Enter Your Email',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[800], fontSize: 16.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                        // color: Color.fromARGB(255, 1, 58, 105),
                                      )),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 21, 62,
                                          116), // Border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 25, 26),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            TextFormField(
                              controller: passController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter this field';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15.0),
                              decoration: InputDecoration(
                                // fillColor: Colors.white,
                                hintText: 'Enter Your Password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 16.0),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      // color: Colors.grey[850],
                                    )),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 21, 62,
                                        116), // Border color when focused
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 21, 62, 116),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    //ButtonStyle(
                                    // backgroundColor: WidgetStatePropertyAll(
                                    //     Color.fromARGB(255, 1, 58, 105)),
                                    //     shape: WidgetStatePropertyAll(OutlineInputBorder())),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        register();
                                      }

                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return const HomePage();
                                      //   },
                                      // ));
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.alias,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SignUppage();
                            },
                          ));
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: ' Don\'t have an account? ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 44, 108, 161),
                                    fontSize: 16),
                                children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 46, 93, 131),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
