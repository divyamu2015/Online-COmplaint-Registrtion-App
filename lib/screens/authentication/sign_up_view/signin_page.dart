import 'package:flutter/material.dart';

import '../login_view/login_page.dart';
import '../sign_up_service/signup_service.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int uerId = 0;
  bool isLoading = false;
  String? role;

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(const Duration(milliseconds: 100));
    String userName = nameController.text.trim();
    String userEmail = emailController.text.trim();
    String userPass = passController.text.trim();
    String userRole = "user";
    setState(() {
      isLoading = true;
    });

    try {
      final response = await userSignin(
          fullname: userName,
          password: userPass,
          email: userEmail,
          id: uerId,
          role: userRole);

      if (response.message != null &&
          response.message == "User created successfully!") {
        if (mounted) {
          showSuccess('Registration successful!');
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          ));
          // Navigator.pop(context);
        }
      } else {
        showError(response.message ?? "Error registering. Please try again.");
      }
    } catch (e) {
      //print(role);
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
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            double width = constraints.maxWidth; // Get width properly

            return Container(
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Online Complaint',
                      style: TextStyle(
                          color: Color.fromARGB(255, 21, 62, 116),
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name Field
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the Field';
                              }
                              if (value.length < 3) return 'Name too Short';
                              if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                                return 'Enter a valid Name (letters only)';
                              }
                              return null;
                            },
                            decoration: inputDecoration(
                                'Name', Icons.person_outline_outlined),
                          ),
                          const SizedBox(height: 10),

                          // Address Field
                          // TextFormField(
                          //   controller: addressController,
                          //   maxLines: 3,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please fill the Field';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: inputDecoration(
                          //       'Address', Icons.info_outline_rounded),
                          // ),
                          // const SizedBox(height: 10),

                          // Phone Field
                          // TextFormField(
                          //   controller: phoneController,
                          //   keyboardType: TextInputType.number,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter a phone number';
                          //     }
                          //     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          //       return 'Invalid phone number. It should be exactly 10 digits.';
                          //     }
                          //     return null;
                          //   },
                          //   decoration:
                          //       inputDecoration('Phone Number', Icons.phone),
                          // ),
                          // const SizedBox(height: 10),
                          // TextFormField(
                          //   controller: nameController,
                          //   keyboardType: TextInputType.name,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please fill the Field';
                          //     }
                          //     if (value.length < 3) return 'Name too Short';
                          //     if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                          //       return 'Enter a valid Name (letters only)';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: inputDecoration('Age', Icons.date_range),
                          // ),
                          // const SizedBox(height: 10),
                          // TextFormField(
                          //   controller: nameController,
                          //   keyboardType: TextInputType.name,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please fill the Field';
                          //     }
                          //     if (value.length < 3) return 'Name too Short';
                          //     if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                          //       return 'Enter a valid Name (letters only)';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: inputDecoration(
                          //       'Aadhaar Card No', Icons.person_outline_outlined),
                          // ),
                          // const SizedBox(height: 10),
                          // // Place Field
                          // TextFormField(
                          //   controller: placeController,
                          //   decoration: inputDecoration('Place', Icons.place),
                          // ),
                          // const SizedBox(height: 10),

                          // Padding(
                          //   padding: const EdgeInsets.all(16.0),
                          //   child: Wrap(
                          //     alignment: WrapAlignment.start,
                          //     crossAxisAlignment: WrapCrossAlignment.center,
                          //     spacing: 10,
                          //     runSpacing: 5,
                          //     children: [
                          //       const Text('Gender',
                          //           style: TextStyle(fontSize: 16)),
                          //       RadioListTile<String>(
                          //         title: const Text('Male'),
                          //         value: 'Male',
                          //         groupValue: gender,
                          //         onChanged: (value) {
                          //           setState(() {
                          //             gender = value;
                          //           });
                          //         },
                          //       ),
                          //       RadioListTile<String>(
                          //         title: const Text('Female'),
                          //         value: 'Female',
                          //         groupValue: gender,
                          //         onChanged: (value) {
                          //           setState(() {
                          //             gender = value;
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // const SizedBox(height: 20),

                          // Ward Selection with Refresh Button

                          // const SizedBox(height: 10),

                          // Email Field
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value!);
                              if (value.isEmpty) {
                                return 'Please Enter Email Address';
                              }
                              if (!emailValid) {
                                return 'Please Enter Valid Email Address';
                              }
                              return null;
                            },
                            decoration:
                                inputDecoration('Email', Icons.email_outlined),
                          ),
                          const SizedBox(height: 10),

                          // Password Field
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
                            // obscureText: true,
                            decoration:
                                inputDecoration('Password', Icons.lock_outline),
                          ),
                          const SizedBox(height: 10),

                          // Sign Up Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fixedSize: Size.fromWidth(width),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 70, 146, 72),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 21, 62, 116),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                register();
                              }
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    ));
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(255, 5, 92, 59),
      ),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
