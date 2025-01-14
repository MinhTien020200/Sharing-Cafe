import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';

class DiscussingItem extends StatefulWidget {
  final String ownerAvatar;
  final String ownerName;
  final String title;
  final String content;
  const DiscussingItem(
      {super.key,
      required this.ownerAvatar,
      required this.ownerName,
      required this.title,
      required this.content});

  @override
  State<DiscussingItem> createState() => _DiscussingItemState();
}

class _DiscussingItemState extends State<DiscussingItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.ownerAvatar),
            ),
            title: Text(
              widget.ownerName,
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF333333)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(widget.content),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {},
              ),
            ],
          ),
          // reply list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.ownerAvatar),
                ),
                title: const Text('Reply owner name'),
                subtitle: const Text('Reply content'),
              );
            },
          ),

          const Divider(
            color: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
