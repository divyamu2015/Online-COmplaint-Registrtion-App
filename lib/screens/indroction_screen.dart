import 'package:flutter/material.dart';
import 'package:online_complaint_registration/screens/authentication/login_view/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  String? userName;
  int? userId;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/12325319_4952521.jpg",
      "title": "Online Complaint Registration",
      "description": "Report issues easily from anywhere, anytime.",
    },
    {
      "image": "assets/images/compl.jpg",
      "title": "Track Your Complaints",
      "description": "Monitor the status of your complaints in real-time.",
    },
    {
      "image": "assets/images/complaintss.jpg",
      "title": "Complaint History",
      "description": "Review your past complaints and resolutions."
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const LoginPage(
            //userId: userId!
            );
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]["image"]!,
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: _currentPage < onboardingData.length - 1
                  ? TextButton(
                      onPressed: _goToLogin,
                      child: const Text("Skip",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: _nextPage,
                    child: Text(_currentPage == onboardingData.length - 1
                        ? "Finish"
                        : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String
      image,
      title,
      description;

  const OnboardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(image, height: 250),
        ),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
