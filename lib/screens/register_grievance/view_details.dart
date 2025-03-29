import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    void showDialogbox(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('You want to Delete'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Complaint detail deleted successfully',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ));
                      },
                      child: const Text('Yes')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'))
                ],
              )
            ],
          );
        },
      );
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 71, 121, 161),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 82, 138),
        title: const Text(
          'View Grievance Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'Grievance ID:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'ID',
                    style: TextStyle(
                        // color: Colors.green,
                        //  fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Full Name:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Name',
                    style: TextStyle(
                        //color: Colors.green,
                        // fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Street Name:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Street',
                    style: TextStyle(
                        // color: Colors.green,
                        //   fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Complaint Type:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Water Leakage on public Taps',
                    style: TextStyle(
                        //  color: Colors.green,
                        //  fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Description:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Description',
                    style: TextStyle(
                        //   color: Colors.green,
                        // fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Image:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Document',
                    style: TextStyle(
                        // color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Current Status',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Closed',
                    style: TextStyle(
                        color: Color.fromARGB(255, 162, 250, 166),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Submission Date and Time',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    'Date and Time',
                    style: TextStyle(
                        // color: Colors.green,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: cross,
                children: [
                  // ElevatedButton.icon(onPressed: () {},,
                  //  child: Text('Edit')),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialogbox(context);
                    },
                    label: const Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    icon: const Icon(Icons.delete),
                  )
                ],
              )
              // ListView.builder(itemBuilder: itemBuilder)
            ],
          ),
        ),
      ),
    ));
  }
}
