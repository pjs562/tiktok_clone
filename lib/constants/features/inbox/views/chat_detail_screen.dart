import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/inbox/view_models/messages_view_model.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import '../../../../common/widgets/dark_mode_configuration/dark_mode_config.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
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
      ref.read(messagesProvider.notifier).sendMessages(message);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = darkModConfig.value;
    final isLoading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      backgroundColor: isDark ? null : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            clipBehavior: Clip.none,
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
            '준서 ${widget.chatId}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: isDark ? null : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: isDark ? null : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom: MediaQuery .of(context).padding.bottom + Sizes.size96,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine = message.userId == ref.watch(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                              Sizes.size14,
                            ),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(
                                  Sizes.size20,
                                ),
                                topRight: const Radius.circular(
                                  Sizes.size20,
                                ),
                                bottomLeft: Radius.circular(
                                    isMine ? Sizes.size20 : Sizes.size5),
                                bottomRight: Radius.circular(
                                    isMine ? Sizes.size5 : Sizes.size20),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size12,
                vertical: Sizes.size12,
              ),
              color: darkModConfig.value ? null : Colors.grey.shade100,
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
                        fillColor: isDark ? Colors.grey.shade600 : Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Sizes.size12,
                        ),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.faceGrin,
                              color:
                                  isDark ? Colors.grey.shade300 : Colors.black,
                            ),
                            Gaps.h10,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : _isButtonEnabled
                            ? _onSendMessage
                            : null,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isButtonEnabled
                            ? Theme.of(context).primaryColor
                            : isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade300,
                      ),
                      child: FaIcon(
                        isLoading
                            ? FontAwesomeIcons.hourglass
                            : FontAwesomeIcons.solidPaperPlane,
                        size: Sizes.size18,
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
