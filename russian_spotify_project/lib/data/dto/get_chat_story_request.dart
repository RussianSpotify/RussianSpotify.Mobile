class GetChatStoryRequest {
  final int pageNumber;
  final int pageSize;

  GetChatStoryRequest({
    this.pageNumber = DefaultsPagination.pageNumber,
    this.pageSize = DefaultsPagination.chatPageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber > 0 ? pageNumber : DefaultsPagination.pageNumber,
      'pageSize': pageSize > 0 ? pageSize : DefaultsPagination.chatPageSize,
    };
  }
}

class DefaultsPagination {
  static const int pageNumber = 1;
  static const int chatPageSize = 10;
}
