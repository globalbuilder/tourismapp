import 'package:flutter/material.dart';

enum MessageType { success, error, info, warning }

class MessageDisplay extends StatelessWidget {
  final String message;
  final MessageType type;
  final VoidCallback? onDismiss;

  const MessageDisplay({
    Key? key,
    required this.message,
    required this.type,
    this.onDismiss,
  }) : super(key: key);

  Color _bgColor() {
    switch (type) {
      case MessageType.success:
        return Colors.green.shade100;
      case MessageType.error:
        return Colors.red.shade100;
      case MessageType.info:
        return Colors.blue.shade100;
      case MessageType.warning:
        return Colors.amber.shade100;
    }
  }

  Color _textColor() {
    switch (type) {
      case MessageType.success:
        return Colors.green.shade900;
      case MessageType.error:
        return Colors.red.shade900;
      case MessageType.info:
        return Colors.blue.shade900;
      case MessageType.warning:
        return Colors.amber.shade900;
    }
  }

  IconData _iconData() {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle_outline;
      case MessageType.error:
        return Icons.error_outline;
      case MessageType.info:
        return Icons.info_outline;
      case MessageType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _textColor(), width: 1),
      ),
      child: Row(
        children: [
          Icon(_iconData(), color: _textColor()),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: _textColor(), fontSize: 16),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: Icon(Icons.close, color: _textColor()),
              onPressed: onDismiss,
            ),
        ],
      ),
    );

    if (onDismiss != null) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismiss!(),
        child: container,
      );
    }
    return container;
  }
}
