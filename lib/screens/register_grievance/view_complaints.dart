import 'package:flutter/material.dart';

import 'view_details.dart';

class ViewComplaints extends StatelessWidget {
  const ViewComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 71, 121, 161),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 14, 82, 138),
            title: const Text(
              'Grievance Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            bottom: const TabBar(
              unselectedLabelColor: Color.fromARGB(255, 54, 2, 2),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 19),
              tabs: [
                Tab(text: 'All Grievances'),
                Tab(text: 'Pending'),
                Tab(text: 'Closed'),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Search Field
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search by Complaint Number',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Search Button
                    ElevatedButton(
                      onPressed: () {
                        // Add search logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // TabBarView for Tabs Content
              Expanded(
                child: TabBarView(
                  children: [
                    // All Grievances Tab
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Grievance Id $index'),
                                    const Text('Status')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('$index'),
                                    const Text('Status')
                                  ],
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey[300]),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const ViewDetails();
                                        },
                                      ));
                                    },
                                    child: const Text('View Details'))
                              ],
                            ),
                            //  ListTile(
                            //   title: Text('All Grievance $index'),
                            //   subtitle: Text('Details for grievance $index'),
                            //   onTap: () {
                            //     // Handle tap logic
                            //   },
                            // ),
                          ),
                        );
                      },
                    ),
                    // Pending Tab
                    ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.hourglass_bottom),
                              title: Text('Pending Grievance $index'),
                              subtitle:
                                  Text('Details for pending grievance $index'),
                              onTap: () {
                                // Handle tap logic
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    // Closed Tab
                    ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.check_circle_outline),
                              title: Text('Closed Grievance $index'),
                              subtitle:
                                  Text('Details for closed grievance $index'),
                              onTap: () {
                                // Handle tap logic
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ViewComplaints(),
  ));
}
