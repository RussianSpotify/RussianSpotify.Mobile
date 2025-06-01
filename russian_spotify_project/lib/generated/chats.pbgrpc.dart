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

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'chats.pb.dart' as $0;

export 'chats.pb.dart';

@$pb.GrpcServiceName('ChatService')
class ChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$sendMessageStream = $grpc.ClientMethod<$0.SendMessageStreamRequest, $0.SendMessageStreamResponse>(
      '/ChatService/SendMessageStream',
      ($0.SendMessageStreamRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendMessageStreamResponse.fromBuffer(value));

  ChatServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$0.SendMessageStreamResponse> sendMessageStream($async.Stream<$0.SendMessageStreamRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendMessageStream, request, options: options);
  }
}

@$pb.GrpcServiceName('ChatService')
abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SendMessageStreamRequest, $0.SendMessageStreamResponse>(
        'SendMessageStream',
        sendMessageStream,
        true,
        true,
        ($core.List<$core.int> value) => $0.SendMessageStreamRequest.fromBuffer(value),
        ($0.SendMessageStreamResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.SendMessageStreamResponse> sendMessageStream($grpc.ServiceCall call, $async.Stream<$0.SendMessageStreamRequest> request);
}
