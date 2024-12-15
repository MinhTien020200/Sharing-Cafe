enum MenuState { home, event, matches, blog, profile }

enum MatchStatus {
  matched(label: "Matched"),
  pending(label: "Pending"),
  declined(label: "Declined"),
  accepted(label: "Accepted"),
  dislike(label: "Dislike");

  final String label;
  const MatchStatus({required this.label});
}

enum NotificationStatus {
  unread(label: "NEW"),
  read(label: "READED");

  final String label;
  const NotificationStatus({required this.label});

  static NotificationStatus fromString(String status) {
    switch (status) {
      case "NEW":
        return NotificationStatus.unread;
      case "READED":
        return NotificationStatus.read;
      default:
        return NotificationStatus.unread;
    }
  }
}

enum ImageType {
  user(value: 1),
  event(value: 2),
  blog(value: 3),
  comment(value: 4);

  final int value;
  const ImageType({required this.value});

  static ImageType fromInt(int value) {
    switch (value) {
      case 1:
        return ImageType.user;
      case 2:
        return ImageType.event;
      case 3:
        return ImageType.blog;
      case 4:
        return ImageType.comment;
      default:
        return ImageType.user;
    }
  }
}

enum DiscussingType {
  event(value: 1),
  blog(value: 2);

  final int value;
  const DiscussingType({required this.value});

  static DiscussingType fromInt(int value) {
    switch (value) {
      case 1:
        return DiscussingType.event;
      case 2:
        return DiscussingType.blog;
      default:
        return DiscussingType.event;
    }
  }
}
