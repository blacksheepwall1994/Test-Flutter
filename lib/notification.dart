import 'dart:convert';

class NotificationResponse {
  NotificationResponse({
    this.data,
  });

  final List<Datum>? data;

  factory NotificationResponse.fromRawJson(String str) =>
      NotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class Datum {
  Datum({
    required this.id,
    this.type,
    required this.title,
    this.message,
    this.image,
    this.icon,
    this.status,
    this.subscription,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.receivedAt,
    this.imageThumb,
    this.animation,
    this.tracking,
    this.subjectName,
    this.isSubscribed,
  });

  late String id;
  final String? type;
  late String title;
  final Message? message;
  final String? image;
  final String? icon;
  final Status? status;
  final Subscription? subscription;
  final int? readAt;
  final int? createdAt;
  final int? updatedAt;
  final int? receivedAt;
  final String? imageThumb;
  final String? animation;
  final String? tracking;
  final String? subjectName;
  final bool? isSubscribed;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) {
    Datum datum = Datum(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      message: Message.fromJson(json["message"]),
      image: json["image"],
      icon: json["icon"],
      status: json["status"] == null ? null : statusValues.map[json["status"]]!,
      subscription: json["subscription"] == null
          ? null
          : Subscription.fromJson(json["subscription"]),
      readAt: json["readAt"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      receivedAt: json["receivedAt"],
      imageThumb: json["imageThumb"],
      animation: json["animation"],
      tracking: json["tracking"],
      subjectName: json["subjectName"],
      isSubscribed: json["isSubscribed"],
    );
    return datum;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "message": message?.toJson(),
        "image": image,
        "icon": icon,
        "status": status == null ? null : statusValues.reverse[status],
        "subscription": subscription?.toJson(),
        "readAt": readAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "receivedAt": receivedAt,
        "imageThumb": imageThumb,
        "animation": animation,
        "tracking": tracking,
        "subjectName": subjectName,
        "isSubscribed": isSubscribed,
      };
}

class Message {
  Message({
    this.text,
    this.highlights,
  });

  final String? text;
  final List<Highlight>? highlights;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json["text"],
        highlights: json["highlights"] == null
            ? null
            : List<Highlight>.from(
                json["highlights"].map((x) => Highlight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "highlights": highlights == null
            ? null
            : List<dynamic>.from(highlights?.map((x) => x.toJson()) ?? []),
      };
}

class Highlight {
  Highlight({
    this.offset,
    this.length,
  });

  final int? offset;
  final int? length;

  factory Highlight.fromRawJson(String str) =>
      Highlight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        offset: json["offset"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "length": length,
      };
}

enum Status { unread, read }

final statusValues = EnumValues({"read": Status.read, "unread": Status.unread});

class Subscription {
  Subscription({
    this.targetId,
    this.targetType,
    this.targetName,
    this.level,
  });

  final String? targetId;
  final TargetType? targetType;
  final String? targetName;
  final int? level;

  factory Subscription.fromRawJson(String str) =>
      Subscription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        targetId: json["targetId"],
        targetType: json["targetType"] == null
            ? null
            : targetTypeValues.map[json["targetType"]],
        targetName: json["targetName"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "targetId": targetId,
        "targetType":
            targetType == null ? null : targetTypeValues.reverse[targetType],
        "targetName": targetName,
        "level": level,
      };
}

enum TargetType { group, user, post }

final targetTypeValues = EnumValues({
  "group": TargetType.group,
  "post": TargetType.post,
  "user": TargetType.user
});

class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
