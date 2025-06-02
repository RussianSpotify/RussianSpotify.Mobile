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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sendMessageStreamRequestDescriptor instead')
const SendMessageStreamRequest$json = {
  '1': 'SendMessageStreamRequest',
  '2': [
    {'1': 'receiver_id', '3': 1, '4': 1, '5': 9, '10': 'receiverId'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `SendMessageStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageStreamRequestDescriptor = $convert.base64Decode(
    'ChhTZW5kTWVzc2FnZVN0cmVhbVJlcXVlc3QSHwoLcmVjZWl2ZXJfaWQYASABKAlSCnJlY2Vpdm'
    'VySWQSGAoHY29udGVudBgDIAEoCVIHY29udGVudA==');

@$core.Deprecated('Use sendMessageStreamResponseDescriptor instead')
const SendMessageStreamResponse$json = {
  '1': 'SendMessageStreamResponse',
  '2': [
    {'1': 'sender_id', '3': 1, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `SendMessageStreamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageStreamResponseDescriptor = $convert.base64Decode(
    'ChlTZW5kTWVzc2FnZVN0cmVhbVJlc3BvbnNlEhsKCXNlbmRlcl9pZBgBIAEoCVIIc2VuZGVySW'
    'QSGgoIdXNlcm5hbWUYAiABKAlSCHVzZXJuYW1lEhgKB2NvbnRlbnQYAyABKAlSB2NvbnRlbnQ=');

