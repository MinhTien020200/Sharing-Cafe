import 'package:flutter/material.dart';

class DiscussingPopup extends StatefulWidget {
  const DiscussingPopup({super.key});

  @override
  State<DiscussingPopup> createState() => _DiscussingPopupState();
}

class _DiscussingPopupState extends State<DiscussingPopup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Tạo thảo luận mới'),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Nhập tiêu đề',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Nhập nội dung',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }
}
