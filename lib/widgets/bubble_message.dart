import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  late final Key key;
  final String username;

  final String message;

  final bool isSender;

  BubbleMessage({
    required this.message,
    required this.username,
    required this.isSender,
    required this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: isSender ? Colors.deepPurpleAccent : Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14),
              topRight: const Radius.circular(14),
              bottomLeft: isSender
                  ? const Radius.circular(0)
                  : const Radius.circular(14),
              bottomRight: !isSender
                  ? const Radius.circular(0)
                  : const Radius.circular(14),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
