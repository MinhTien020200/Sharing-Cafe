import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/model/comment_model.dart';
import 'package:sharing_cafe/service/event_service.dart';

class DiscussingItem extends StatefulWidget {
  final String id;
  final String ownerAvatar;
  final String ownerName;
  final String title;
  final String content;
  final int likeCount;
  final bool isLiked;
  const DiscussingItem(
      {super.key,
      required this.id,
      required this.ownerAvatar,
      required this.ownerName,
      required this.title,
      required this.content,
      required this.likeCount,
      required this.isLiked});

  @override
  State<DiscussingItem> createState() => _DiscussingItemState();
}

class _DiscussingItemState extends State<DiscussingItem> {
  final TextEditingController _controller = TextEditingController();
  List<CommentModel> comments = [];
  bool isCommenting = false;
  int _likeCount = 0;
  bool _isLike = false;
  bool isLiking = false;
  @override
  void initState() {
    _likeCount = widget.likeCount;
    _isLike = widget.isLiked;
    super.initState();
    getComments();
  }

  Future getComments() async {
    var result = await EventService().getDiscussionComments(widget.id);
    setState(() {
      comments = result.reversed.toList();
    });
  }

  Future likeDiscuss() {
    return EventService().likeDiscuss(widget.id, !_isLike);
  }

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
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Bình luận',
                    border: OutlineInputBorder(),
                  ),
                  controller: _controller,
                ),
              ),
              isCommenting
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        setState(() {
                          isCommenting = true;
                        });
                        await EventService()
                            .commentDiscussion(widget.id, _controller.text);
                        await getComments();
                        setState(() {
                          isCommenting = false;
                          _controller.clear();
                        });
                      },
                    ),
              Text('$_likeCount'),
              isLiking
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ))
                  : IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: _isLike ? kPrimaryColor : null,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiking = true;
                        });
                        likeDiscuss().then((value) {
                          setState(() {
                            _isLike = !_isLike;
                            _likeCount =
                                _isLike ? _likeCount + 1 : _likeCount - 1;
                            isLiking = false;
                          });
                        });
                      },
                    ),
            ],
          ),
          // reply list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(comment.profileAvatar),
                ),
                title: Text(comment.userName),
                subtitle: Text(comment.content),
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
