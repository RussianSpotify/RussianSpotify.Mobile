import 'package:flutter/material.dart';

abstract class ConfirmationEvent {}

class InitializeFromContext extends ConfirmationEvent {
  final BuildContext context;

  InitializeFromContext(this.context);
}

class UpdateConfirmationCode extends ConfirmationEvent {
  final String code;

  UpdateConfirmationCode(this.code);
}

class HandleConfirmClick extends ConfirmationEvent {
  final BuildContext context;

  HandleConfirmClick(this.context);
}
