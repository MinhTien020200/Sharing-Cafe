import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';

class CreateEventScreen extends StatefulWidget {
  static String routeName = "/create-event";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // You will need to manage the state for the inputs and selections
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo sự kiện',
          style: heading2Style,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                // Handle attend action
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kPrimaryColor),
                padding: MaterialStateProperty.resolveWith(
                    (states) => const EdgeInsets.symmetric(horizontal: 16.0)),
              ),
              child: const Text(
                'Đăng',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Open image picker
            },
            child: Container(
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tên sự kiện',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Update event name
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ngày và giờ bắt đầu',
              border: OutlineInputBorder(),
            ),
            onTap: () {
              // Show date picker
            },
          ),
          const SizedBox(height: 16),
          // Add more TextFormFields and buttons for other fields
        ],
      ),
    );
  }
}
