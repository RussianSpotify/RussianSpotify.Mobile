//
//  Generated code. Do not modify.
//  source: chats.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SendMessageStreamRequest extends $pb.GeneratedMessage {
  factory SendMessageStreamRequest({
    $core.String? receiverId,
    $core.String? content,
  }) {
    final result = create();
    if (receiverId != null) result.receiverId = receiverId;
    if (content != null) result.content = content;
    return result;
  }

  SendMessageStreamRequest._();

  factory SendMessageStreamRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMessageStreamRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageStreamRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiverId')
    ..aOS(3, _omitFieldNames ? '' : 'content')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageStreamRequest clone() =>
      SendMessageStreamRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageStreamRequest copyWith(
          void Function(SendMessageStreamRequest) updates) =>
      super.copyWith((message) => updates(message as SendMessageStreamRequest))
          as SendMessageStreamRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageStreamRequest create() => SendMessageStreamRequest._();
  @$core.override
  SendMessageStreamRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageStreamRequest> createRepeated() =>
      $pb.PbList<SendMessageStreamRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageStreamRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageStreamRequest>(create);
  static SendMessageStreamRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiverId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverId() => clearField(1);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(3)
  set content($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(3)
  void clearContent() => clearField(3);
}

class SendMessageStreamResponse extends $pb.GeneratedMessage {
  factory SendMessageStreamResponse({
    $core.String? senderId,
    $core.String? username,
    $core.String? content,
  }) {
    final result = create();
    if (senderId != null) result.senderId = senderId;
    if (username != null) result.username = username;
    if (content != null) result.content = content;
    return result;
  }

  SendMessageStreamResponse._();

  factory SendMessageStreamResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMessageStreamResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageStreamResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'content')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageStreamResponse clone() =>
      SendMessageStreamResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageStreamResponse copyWith(
          void Function(SendMessageStreamResponse) updates) =>
      super.copyWith((message) => updates(message as SendMessageStreamResponse))
          as SendMessageStreamResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageStreamResponse create() => SendMessageStreamResponse._();
  @$core.override
  SendMessageStreamResponse createEmptyInstance() => create();
  static $pb.PbList<SendMessageStreamResponse> createRepeated() =>
      $pb.PbList<SendMessageStreamResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMessageStreamResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageStreamResponse>(create);
  static SendMessageStreamResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
