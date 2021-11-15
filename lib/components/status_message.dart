import 'package:digital_park/components/container_background.dart';
import 'package:digital_park/components/miscellaneous/centered_message.dart';
import 'package:flutter/material.dart';

class StatusMessage extends StatelessWidget {
  const StatusMessage({
    Key? key,
    required this.errorMessage,
    this.errorIcon,
    this.loading = false,
  }) : super(key: key);

  final String errorMessage;
  final IconData? errorIcon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerBackground(
          child: CenteredMessage(
            errorMessage,
            icon: errorIcon,
            loading: loading,
          ),
        ),
      ),
    );
  }
}
