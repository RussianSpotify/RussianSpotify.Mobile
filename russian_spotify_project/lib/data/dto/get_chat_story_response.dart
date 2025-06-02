class GetChatStoryResponse {
  final List<GetChatStoryResponseItem> entities;
  final int totalCount;

  GetChatStoryResponse({required this.entities, required this.totalCount});

  factory GetChatStoryResponse.fromJson(Map<String, dynamic> json) {
    return GetChatStoryResponse(
      entities:
          (json['entities'] as List<dynamic>)
              .map((item) => GetChatStoryResponseItem.fromJson(item))
              .toList(),
      totalCount: json['totalCount'] as int,
    );
  }
}

class GetChatStoryResponseItem {
  final String id;
  final String message;
  final String sender;
  final String senderId;
  final String? senderImageId;
  final DateTime sentDate;

  GetChatStoryResponseItem({
    required this.id,
    required this.message,
    required this.sender,
    required this.senderId,
    this.senderImageId,
    required this.sentDate,
  });

  factory GetChatStoryResponseItem.fromJson(Map<String, dynamic> json) {
    return GetChatStoryResponseItem(
      id: json['id'] as String,
      message: json['message'] as String,
      sender: json['sender'] as String,
      senderId: json['senderId'] as String,
      senderImageId: json['senderImageId'] as String?,
      sentDate: DateTime.parse(json['sentDate'] as String),
    );
  }
}
