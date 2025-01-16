import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/model/discussing_model.dart';
import 'package:sharing_cafe/provider/event_provider.dart';

class DiscussingPopup extends StatefulWidget {
  final String eventId;
  const DiscussingPopup({super.key, required this.eventId});

  @override
  State<DiscussingPopup> createState() => _DiscussingPopupState();
}

class _DiscussingPopupState extends State<DiscussingPopup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Tạo thảo luận mới'),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Nhập tiêu đề',
              border: OutlineInputBorder(),
            ),
            controller: _titleController,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Nhập nội dung',
              border: OutlineInputBorder(),
            ),
            controller: _contentController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              var discussion = DiscussingModel(
                  refId: widget.eventId,
                  type: DiscussingType.event,
                  title: _titleController.text,
                  content: _contentController.text);
              await Provider.of<EventProvider>(context, listen: false)
                  .createDiscussion(discussion);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }
}
