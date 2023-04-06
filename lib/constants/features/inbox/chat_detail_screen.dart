import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _textEditingController.text.isNotEmpty;
    });
  }

  void _onSendMessage() {
    setState(() {
      String message = _textEditingController.text;
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: 22,
                foregroundImage: NetworkImage(
                  "https://yt3.ggpht.com/mnzLrvJvPhpqDu3q7bJmEfh4dbIhmimi0ZHU5yxK6GuBf6bkgSqajNEqSvHuoSkX0fmVNhwY=s88-c-k-c0x00ffffff-no-rj-mo",
                ),
                child: Text('준서'),
              ),
              Positioned(
                bottom: -3,
                right: -3,
                child: Container(
                  width: Sizes.size18,
                  height: Sizes.size18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF45C73E),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            '준서',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        Sizes.size14,
                      ),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            Sizes.size20,
                          ),
                          topRight: Radius.circular(
                            Sizes.size20,
                          ),
                          bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5),
                          bottomRight: Radius.circular(
                              isMine ? Sizes.size5 : Sizes.size20),
                        ),
                      ),
                      child: Text(
                        "this is a message!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size12,
                vertical: Sizes.size12,
              ),
              elevation: 0,
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Send a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            22,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Sizes.size12,
                        ),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.faceGrin,
                              color: Colors.black,
                            ),
                            Gaps.h10,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  GestureDetector(
                    onTap: _isButtonEnabled ? _onSendMessage : null,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isButtonEnabled
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                      ),
                      child: const FaIcon(
                        size: Sizes.size18,
                        FontAwesomeIcons.solidPaperPlane,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
