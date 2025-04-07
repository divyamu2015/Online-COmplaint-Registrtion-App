import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'home_page.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
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
          child: Center(
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(2, 5),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BounceInDown(
                      child: const Text(
                        'Online Complaint Registration',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 21, 62, 116),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ZoomIn(
                      duration: const Duration(milliseconds: 1200),
                      child: const Column(
                        children: [
                          Text(
                            '''The Online Complaint Registration App is designed to empower citizens by providing a seamless platform to report social issues such as water leakages, illegal waste dumping, and other public concerns. 
                        
Whether you’re a first-time user or a returning one, simply sign up or log in to access the system.
                        
Easily register complaints, track their status, and engage with the community by reacting to issues that matter to you. Our app ensures a smooth experience with dummy payment integration for testing and a support system                         
Join us in making a difference—because every complaint counts!''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'dummy@gmail.com',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 21, 62, 116),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ));
                          },
                          child: const Text(
                            'BACK',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
