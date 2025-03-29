import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../../url/json_url.dart';
import '../home_page.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key, required this.userid});
  final int userid;

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  double rating = 0;
  int? userId;
  TextEditingController feedbackController = TextEditingController();
  @override
  void initState() {
    super.initState();

    userId = widget.userid;
    print(userId);
    // getuseName();
  }

  // Future<void> getuseName() async {
  //   try {
  //     final response = await http.get(Uri.parse(userFeedback),
  //         headers: {'Content-Type': 'application/json'});
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       print('My data================ $data');
  //     }
  //   } catch (e) {}
  // }

  Future<void> submitFeedback() async {
    if (feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your feedback.")),
      );
      return;
    }

    // Backend API URL

    // Data to be sent
    Map<String, dynamic> feedbackData = {
      "user": userId, // Replace with dynamic user ID if needed
      "rate": rating,
      "feedback": feedbackController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(userFeedback),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(feedbackData),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess("Feedback submitted successfully!");
        Navigator.pop(context);

        feedbackController.clear();
        setState(() {
          rating = 0; // Reset rating after submission
        });
      } else {
        showError("Failed to submit feedback: ${response.body}");
      }
    } catch (e) {
      showError("Error: $e");
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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            "Feedback",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 71, 95, 148),
        ),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Rate Our Service",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (ratingValue) {
                    setState(() {
                      rating = ratingValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text("Your Feedback",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  controller: feedbackController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Write your feedback here...",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 97, 113, 170),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Submit Feedback",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
