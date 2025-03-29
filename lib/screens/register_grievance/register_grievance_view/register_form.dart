import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_complaint_registration/widgets/sizebox.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../history_page.dart';
import '../bloc/register_grievance_bloc.dart';
import '../view_complaints.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ComplaintRegistration extends StatefulWidget {
  const ComplaintRegistration({super.key});

  @override
  State<ComplaintRegistration> createState() => _ComplaintRegistrationState();
}

class _ComplaintRegistrationState extends State<ComplaintRegistration> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController complaintDescription = TextEditingController();
  List<Map<String, dynamic>> category = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCategoryId;
  int? complaintId;

  int? userId;
  File? _aadhaarImage;
  double? latitude;
  double? longitude;
  final ImagePicker _picker = ImagePicker();

  File? _image;
  // final ImagePicker _picker = ImagePicker();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  // Existing code...

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(onResult: (result) {
          setState(() {
            complaintDescription.text =
                result.recognizedWords; // Update the TextFormField
          });
        });
      }
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError('Location Services disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError('Location Permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showError('Location Permission denied forever');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, distanceFilter: 10),
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _getCategory() async {
    try {
      final response = await http.get(Uri.parse(
          'https://417sptdw-8004.inc1.devtunnels.ms/userapp/categories/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          category = List<Map<String, dynamic>>.from(data);
        });
      } else {
        showError('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      showError('Network Error: ${e.toString()}');
    }
  }

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Submitted Successfully',
          ),
          actions: [
            Center(
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ViewComplaints();
                      },
                    ));
                  },
                  child: const Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAadhaarImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery); // or ImageSource.camera
    if (image != null) {
      setState(() {
        _aadhaarImage = File(image.path);
      });
    }
  }

  Future<void> _uploadAadhaarPhoto(BuildContext context) async {
    if (_aadhaarImage == null) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://417sptdw-8004.inc1.devtunnels.ms/userapp/userreg/'),
    );

    request.files.add(await http.MultipartFile.fromPath(
        'aadhaar_photo', _aadhaarImage!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      _showMessage(
          context, "Aadhaar photo uploaded successfully!", Colors.green);
    } else {
      _showMessage(context, "Failed to upload Aadhaar photo. Please try again.",
          Colors.red);
    }
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  String getFullImageUrl(String? imagePath) {
    const String baseUrl = "https://417sptdw-8004.inc1.devtunnels.ms";
    if (imagePath == null || imagePath.isEmpty) {
      return "https://via.placeholder.com/150"; // Default placeholder image
    }
    return Uri.encodeFull("$baseUrl/$imagePath");
  }

  Future<void> registerUser() async {
    // Validate Aadhaar photo
    if (_aadhaarImage == null) {
      showError('Please select your Aadhaar photo.');
      return;
    }

    // Validate location
    if (latitude == null || longitude == null) {
      showError('Please fetch your location.');
      return;
    }

    // Validate selected date
    // if (selectedDate.isBefore(DateTime.now())) {
    //   showError('Please select a valid date.');
    //   return;
    // }

    // Validate supporting evidence
    if (_image == null) {
      showError('Please upload supporting evidence.');
      return;
    }

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate); // Format the date

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? retrievedData = prefs.getInt('id'); // Retrieve user ID

    if (retrievedData != null) {
      userId = retrievedData;
      print("User  ID retrieved from SharedPreferences: $userId");
    } else {
      print("No User ID found in SharedPreferences.");
    }

    // Proceed with the registration process
    if (userId != null) {
      context
          .read<RegisterGrievanceBloc>()
          .add(RegisterGrievanceEvent.complaintregister(
              //  id: complaintId!,
              name: name.text,
              email: email.text.trim(),
              phone: phoneNumber.text,
              address: address.text,
              city: place.text,
              latitude: latitude!.toString(),
              longitude: longitude!.toString(),
              photo: _image!.path,
              date: formattedDate, // Use the formatted date
              description: complaintDescription.text,
              aadhaarPhoto: _aadhaarImage!.path,
              category: int.tryParse(selectedCategoryId ?? '0') ?? 0,
              userId: userId!));
    } else {
      print("Error: userId is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 22, 43),
        // backgroundColor: const Color.fromARGB(255, 2, 49, 58),

        //backgroundColor: const Color.fromARGB(255, 13, 13, 39),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: const Color.fromARGB(255, 14, 82, 138),
          title: const Text(
            'Online Registration',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: BlocListener<RegisterGrievanceBloc, RegisterGrievanceState>(
          listener: (context, state) {
            state.when(
                initial: () {},
                loading: () => setState(() {
                      isLoading = true;
                    }),
                success: (response) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Registration successful!'),
                        backgroundColor: Colors.green),
                  );
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return HistoryPage(
                        userId: userId!,
                      );
                    },
                  ));
                  name.clear();
                  email.clear();
                  phoneNumber.clear();
                  address.clear();
                  place.clear();
                  complaintDescription.clear();
                  latitude = null; // or 0.0 if you prefer
                  longitude = null; // or 0.0 if you prefer
                  _image = null; // Reset the image
                  _aadhaarImage = null; // Reset the Aadhaar image
                  selectedCategoryId = null; // Reset the selected category
                  selectedDate = DateTime.now();
                },
                error: (error) {
                  setState(() {
                    isLoading = false;
                  });
                  showError(error);
                });
          },
          child: Container(
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
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 8, 8, 8)),
                      ),
                      const SizedBox(height: 15.0),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 8, 8, 8)),
                      ),
                      const SizedBox(height: 15.0),

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: phoneNumber,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 8, 8, 8)),
                      ),
                      const SizedBox(height: 15.0),

                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        controller: place,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 8, 8, 8)),
                      ),
                      const SizedBox(height: 15.0),

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: address,
                        decoration: InputDecoration(
                          hintText: 'Place',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 8, 8, 8)),
                      ),
                      const SizedBox(height: 15.0),

                      //const Sizebox(he: 15.0, wi: 0.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: unnecessary_null_comparison
                          _aadhaarImage != null
                              ? Image.file(
                                  _aadhaarImage!,
                                  height: 150,
                                )
                              : const Text("",
                                  style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromARGB(255, 255, 255, 255))),
                            onPressed: _pickAadhaarImage,
                            icon: const Icon(
                              Icons.upload,
                              color: Color.fromARGB(255, 44, 108, 161),
                            ),
                            label: const Text(
                              "Select Aadhaar Photo",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 44, 108, 161)),
                            ),
                          ),
                        ],
                      ),
                      Sizebox(he: 0.1 * height, wi: 0.0),
                      const Align(
                        child: Text(
                          'Required Details',
                          style: TextStyle(
                              fontSize: 23.0,
                              color: Color.fromARGB(255, 23, 71, 110),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    color: Colors.black87,
                                    offset: Offset.infinite,
                                    blurRadius: 0.3)
                              ]),
                        ),
                      ),
                      Sizebox(he: 0.1 * height, wi: 0.0),
                      DropdownButtonFormField<String>(
                        value:
                            selectedCategoryId, // Ensure this is a String variable
                        hint: const Text('Select Complaint Category'),
                        validator: (value) => value == null
                            ? 'Please select a complaint category'
                            : null,
                        items: category.map((cat) {
                          return DropdownMenuItem<String>(
                            value:
                                cat['id'].toString(), // Using ID as the value
                            child: Text(cat['name']), // Display category name
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryId =
                                value; // Update selected category ID
                          });
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Complaint Category",
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 10, 10, 10),
                          ),
                        ),
                      ),

                      const Sizebox(he: 15.0, wi: 0.0),

                      // const Sizebox(he: 35.0, wi: 0.0),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Prevents unnecessary expansion
                          children: [
                            ElevatedButton.icon(
                              onPressed: fetchLocation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 44, 108, 161),
                              ),
                              label: const Text(
                                'Location',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              icon: const Icon(Icons.location_on_outlined,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                                width: 10), // Reduce spacing to avoid overflow
                            Expanded(
                              // Allows text to adjust dynamically
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Latitude: ${latitude?.toStringAsFixed(6) ?? '0.0'}",
                                    overflow: TextOverflow
                                        .ellipsis, // Prevents text overflow
                                  ),
                                  Text(
                                    "Longitude: ${longitude?.toStringAsFixed(6) ?? '0.0'}",
                                    overflow: TextOverflow
                                        .ellipsis, // Prevents text overflow
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.all(12), // Spacing inside the box
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          border: Border.all(
                              color: Colors.grey, width: 1), // Border styling
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // Soft shadow
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Evenly space items
                          children: [
                            Text(
                              "Date: ${DateFormat('dd-MM-yyyy').format(selectedDate)}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            ElevatedButton(
                              onPressed: () => selectDate(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 44, 108, 161),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                "Pick a Date",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: _showImageSourceDialog,
                        icon: const Icon(
                          Icons.upload_file,
                          color: Color.fromARGB(255, 44, 108, 161),
                        ),
                        label: const Text(
                          "Upload Supporting Evidence",
                          style: TextStyle(
                              color: Color.fromARGB(255, 44, 108, 161),
                              fontSize: 15),
                        ),
                      ),
                      if (_image != null) // Display the selected image
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.file(
                            _image!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const Sizebox(he: 15.0, wi: 0.0),

                      TextFormField(
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        controller: complaintDescription,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 8, 8, 8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Complaint Description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Complaint Description',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isListening ? Icons.stop : Icons.mic,
                              color: Colors.blue,
                            ),
                            onPressed:
                                _isListening ? _stopListening : _startListening,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Voice to Text Button
                      // ElevatedButton(
                      //   onPressed:
                      //       _isListening ? _stopListening : _startListening,
                      //   child: Text(_isListening
                      //       ? 'Stop Listening'
                      //       : 'Start Listening'),
                      // ),

                      const SizedBox(height: 35),
                      Center(
                          child: SizedBox(
                        width: 250,
                        child: ElevatedButton.icon(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 21, 62, 116))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registerUser(); // Call the registerUser  method
                            }
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return StatusForm();
                            //   },
                            // ));
                          },
                          label: const Text(
                            'Register',
                            style: TextStyle(
                                color: Color.fromARGB(255, 245, 246, 247),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          icon: const Icon(
                            Icons.app_registration_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
