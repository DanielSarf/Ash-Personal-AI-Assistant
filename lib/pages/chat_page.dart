import 'package:ash_personal_assistant/services/generate.dart';
import 'package:ash_personal_assistant/theme/colors.dart';
import 'package:ash_personal_assistant/theme/font_styles.dart';
import 'package:ash_personal_assistant/utils/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ash_personal_assistant/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String chatName;

  const ChatPage({super.key, required this.chatName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => Auth().currentUser;

  @override
  void initState() {
    super.initState();
    if (currentUser == null) {
      Auth().signOut();
    }
  }

  Future<String> getTurnicatedAndFormattedChatHistory(int charLimit) async {
    if (currentUser == null) {
      return '';
    }

    final querySnapshot = await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc(widget.chatName)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .get();

    List<Map<String, dynamic>> messages =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    //EoT token
    charLimit = charLimit - 1;

    String messageText = "";

    for (var message in messages) {
      messageText += message['sender'] == 'user'
          ? '<|user|>${message['message']}<|end|>'
          : '<|assistant|>${message['message']}<|end|>';
    }

    messageText = messageText.trim();
    messageText += "<|assistant|>";

    List<String> messageCharacters = messageText.split('');

    if (messageCharacters.length <= charLimit) {
      return messageText;
    }

    messageText = "";

    for (int i = 0; i < messageCharacters.length; i++) {
      if (i >= messageCharacters.length - charLimit) {
        messageText += messageCharacters[i];
      }
    }

    messageText.trim();

    return messageText;
  }

  void sendMessage(String messageText, String sender) async {
    if (currentUser != null) {
      final message = {
        'sender': sender,
        'message': messageText,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('chats')
          .doc(widget.chatName)
          .collection('messages')
          .add(message);

      messageController.clear();

      if (sender == "user") {
        getTurnicatedAndFormattedChatHistory(5000)
            .then((chat) => sendMessage(generateMessage(chat), "assistant"));
      }
    }
  }

  Stream<QuerySnapshot> getChatMessagesStream() {
    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc(widget.chatName)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const ColorPalette().night,
      appBar: AppBar(
        iconTheme: IconThemeData(color: const ColorPalette().mintCream),
        backgroundColor: const ColorPalette().night,
        title: Text(
          widget.chatName,
          style: defaultFontStyle(
            FontWeight.w300,
            const ColorPalette().mintCream,
            22,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getChatMessagesStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUserMessage = message['sender'] == 'user';

                    return ChatBubble(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      shadowColor: Colors.transparent,
                      clipper: ChatBubbleClipper5(
                        type: isUserMessage
                            ? BubbleType.sendBubble
                            : BubbleType.receiverBubble,
                      ),
                      margin: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: isUserMessage ? 10 : 50,
                        left: isUserMessage ? 50 : 10,
                      ),
                      alignment: isUserMessage
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      backGroundColor: isUserMessage
                          ? const ColorPalette().byzantineBlue
                          : const ColorPalette().jade,
                      child: Text(
                        message['message'],
                        style: defaultFontStyle(FontWeight.w300,
                            const ColorPalette().mintCream, 18),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: const ColorPalette().night,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: messageController,
                      textColor: const ColorPalette().mintCream,
                      hintText: "Type a message...",
                      cornerRadius: 7.5,
                      fontSize: 18,
                      height: 50,
                      width: 300,
                      borderColor: const ColorPalette().mintCream,
                      borderWidth: 1,
                      focusBorderColor: const ColorPalette().mintCream,
                      focusBorderWidth: 1,
                      backgroundColor: const ColorPalette().night,
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.send, color: const ColorPalette().mintCream),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        sendMessage(messageController.text, 'user');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
