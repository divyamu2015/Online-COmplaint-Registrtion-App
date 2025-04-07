import 'package:flutter/material.dart';
import 'package:online_complaint_registration/screens/feedback_screen/feedback.dart';
import 'package:page_transition/page_transition.dart';

import 'about_us.dart';
import 'authentication/login_view/login_page.dart';
import 'history_page.dart';
import 'register_grievance/register_grievance_view/register_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.userId = 0});
  final int userId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Home page is the default

  void _onItemTapped(int index) {
    if (index == 1) {
      // Show logout confirmation popup
      _showLogoutDialog();
    } else {
      setState(() {
        _selectedIndex = index; // Stay on Home Page
      });
    }
  }

  int? userid;
  @override
  void initState() {
    super.initState();

    userid = widget.userId;
    print('This is Home Page $userid');
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color.fromARGB(255, 125, 172, 211),
        appBar: AppBar(
          leading: const Icon(
            Icons.online_prediction,
            color: Colors.amber,
            size: 30.0,
          ),
          backgroundColor: const Color.fromARGB(255, 14, 82, 138),
          title: const Text(
            'Online Registration',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 76, 224, 81),
                  size: 30.0,
                ))
          ],
          // leading: SizedBox(
          //   height: 8 * height,
          //   width: 8 * width,
          //   child: Image.asset(
          //     'assets/images/complaint.png',
          //     height: 6 * height,
          //     width: 6 * width,
          //     //color: const Color.fromARGB(255, 105, 177, 117),
          //   ),
          //   //  color: Colors.amber,
          // ),
        ),
        body: Container(
          height: 0.9 * height,
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/images/12325319_4952521.jpg"),
            //   fit: BoxFit.cover,
            //   opacity: 0.1,
            // ),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.6 * height,
                      width: 0.9 * width,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true, // Prevents unnecessary space
                        physics:
                            const NeverScrollableScrollPhysics(), // Prevents double scrolling

                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const ComplaintRegistration();
                                  },
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // border: Border.all(
                                  //   // color: Colors.grey, // Border color
                                  //   width: 2, // Border width
                                  // ),
                                  // border: ,
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 90,
                                      // color: Colors.amber,
                                      child: Image.asset(
                                        'assets/images/travel.png',
                                        width: 70,
                                        height: 70,
                                        color: const Color.fromARGB(
                                            255, 117, 106, 5),
                                      ),
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(30.0)),
                                    ),
                                    const Text(
                                      'Register Grievance',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          MouseRegion(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return HistoryPage(
                                      userId: userid!,
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // border: Border.all(
                                  //   color: Colors.grey, // Border color
                                  //   width: 2, // Border width
                                  // ),
                                  // border: ,
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 90,
                                        width: 90,
                                        // color: Colors.amber,
                                        child: Image.asset(
                                          'assets/images/paper-plane (1).png',
                                          width: 70,
                                          height: 70,
                                          color: const Color.fromARGB(
                                              255, 43, 124, 134),
                                        )),
                                    const Text(
                                      'View Status',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // color: Colors.grey[300],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              // border: Border.all(
                              //   color: Colors.grey, // Border color
                              //   width: 2, // Border width
                              // ),
                              // border: ,
                              color: Colors.grey[300],
                            ),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return FeedbackPage(userid: userid!);
                                    },
                                  ));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 90,
                                        width: 90,
                                        // color: Colors.amber,
                                        child: Image.asset(
                                          'assets/images/mail.png',
                                          width: 70,
                                          height: 70,
                                          // color: const Color.fromARGB(255, 107, 21, 15),
                                        )),
                                    const Text(
                                      'Feedback on disposal',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        alignment: Alignment.center,
                                        type: PageTransitionType.rotate,
                                        duration: const Duration(seconds: 1),
                                        child: const Aboutus()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // border: Border.all(
                                  //   color: Colors.grey, // Border color
                                  //   width: 2, // Border width
                                  // ),
                                  // border: ,
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 90,
                                        width: 90,
                                        // color: Colors.amber,
                                        child: Image.asset(
                                          'assets/images/complaint (1).png',
                                          width: 70,
                                          height: 70,
                                          //color: const Color.fromARGB(255, 107, 21, 15),
                                        )),
                                    const Text(
                                      'About Us',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                //color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.blue),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout, color: Colors.red),
              label: "Logout",
            ),
          ],
        ),
      ),
    );
  }
}
