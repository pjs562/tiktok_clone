import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({super.key, required this.text, required this.maxLines});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _onChangeExpanded(){
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _onChangeExpanded,
          child: AnimatedContainer(
            width: 250,
            height: _isExpanded ? 140 : (widget.maxLines * 14),
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.text,
              maxLines: _isExpanded ? 10 : widget.maxLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: Sizes.size14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}