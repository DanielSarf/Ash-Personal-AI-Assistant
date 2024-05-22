import 'package:ash_personal_assistant/services/auth.dart';
import 'package:ash_personal_assistant/pages/chat_page.dart';
import 'package:ash_personal_assistant/theme/colors.dart';
import 'package:ash_personal_assistant/theme/font_styles.dart';
import 'package:ash_personal_assistant/utils/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => Auth().currentUser;

  @override
  void initState() {
    super.initState();
    if (currentUser == null) {
      Auth().signOut();
    }
  }

  Stream<QuerySnapshot> getChatMessagesStream() {
    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _openChat(String name) {
    String chatName = name;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(chatName: chatName),
      ),
    );
  }

  void _showAddChatDialog() {
    final TextEditingController chatNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.5))),
          backgroundColor: const ColorPalette().mintCream,
          title: Text(
            'Create Chat',
            style: defaultFontStyle(
              FontWeight.w400,
              const ColorPalette().night,
              22,
            ),
          ),
          content: TextField(
            cursorColor: const ColorPalette().night,
            style: GoogleFonts.ibmPlexSans(
                color: const ColorPalette().night, fontSize: 18),
            controller: chatNameController,
            decoration: InputDecoration(
              hintText: 'Enter chat name',
              fillColor: const ColorPalette().mintCream,
              focusColor: const ColorPalette().night,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: const ColorPalette().night,
                ),
              ),
            ),
          ),
          actions: [
            CustomButton(
              height: 45,
              width: 90,
              cornerRadius: 7.5,
              backgroundColor: const ColorPalette().tomato,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: defaultFontStyle(
                  FontWeight.w400,
                  const ColorPalette().night,
                  18,
                ),
              ),
            ),
            CustomButton(
              height: 45,
              width: 80,
              cornerRadius: 7.5,
              backgroundColor: const ColorPalette().jade,
              onTap: () async {
                _firestore
                    .collection('users')
                    .doc(currentUser!.uid)
                    .collection('chats')
                    .doc(chatNameController.text)
                    .set({"timestamp": FieldValue.serverTimestamp()});

                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: defaultFontStyle(
                  FontWeight.w400,
                  const ColorPalette().night,
                  18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const ColorPalette().night,
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: const ColorPalette().mintCream, size: 30),
        title: Text(
          "Chats",
          style: defaultFontStyle(
            FontWeight.w300,
            const ColorPalette().mintCream,
            25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showAddChatDialog,
            icon: Icon(
              Icons.add,
              color: const ColorPalette().mintCream,
              size: 40,
            ),
          ),
        ],
        backgroundColor: const ColorPalette().night,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getChatMessagesStream(),
        builder: (context, snapshot) {
          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(
              child: Text(
                "Start a chat with Ash!",
                style: defaultFontStyle(
                    FontWeight.w300, const ColorPalette().mintCream, 18),
              ),
            );
          }

          final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chatName = chats[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.5),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(3, 5, 0, 5),
                    color: Color.fromARGB(
                      10,
                      const ColorPalette().mintCream.red,
                      const ColorPalette().mintCream.green,
                      const ColorPalette().mintCream.blue,
                    ),
                    child: ListTile(
                      onTap: () => _openChat(chatName.id),
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                      title: Text(
                        chatName.id,
                        style: defaultFontStyle(
                          FontWeight.w400,
                          const ColorPalette().mintCream,
                          20,
                        ),
                      ),
                      trailing: PopupMenuButton(
                        iconColor: const ColorPalette().mintCream,
                        color: const ColorPalette().mintCream,
                        onSelected: (value) async {
                          if (value == 'delete') {
                            _firestore
                                .collection('users')
                                .doc(currentUser!.uid)
                                .collection('chats')
                                .doc(chatName.id)
                                .delete();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                'Delete',
                                style: defaultFontStyle(
                                  FontWeight.w400,
                                  const ColorPalette().night,
                                  18,
                                ),
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      drawer: Drawer(
        backgroundColor: const ColorPalette().mintCream,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/onboarding_gradient_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    DrawerHeader(
                      child: Image.asset(
                        "assets/images/ash_text_animation.gif",
                        width: 240,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text(
                        "This application stands as an academic exploration, focused on running Large Language Models (LLMs) locally on handheld devices like smartphones.\n\nWhile the name 'Ash' may be associated with Daniel Sarfraz for potential future endeavors, it does not signify that forthcoming projects are iterations of this application.",
                        style: defaultFontStyle(
                          FontWeight.w400,
                          const ColorPalette().mintCream,
                          12,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: const ColorPalette().mintCream,
                        ),
                        title: Text(
                          "Settings",
                          style: defaultFontStyle(
                            FontWeight.w400,
                            const ColorPalette().mintCream,
                            20,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.help,
                          color: const ColorPalette().mintCream,
                        ),
                        title: Text(
                          "Help",
                          style: defaultFontStyle(
                            FontWeight.w400,
                            const ColorPalette().mintCream,
                            20,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.notes,
                          color: const ColorPalette().mintCream,
                        ),
                        title: Text(
                          "Licenses",
                          style: defaultFontStyle(
                            FontWeight.w400,
                            const ColorPalette().mintCream,
                            20,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: Auth().signOut,
                        leading: Icon(
                          Icons.login_outlined,
                          color: const ColorPalette().mintCream,
                        ),
                        title: Text(
                          "Sign out",
                          style: defaultFontStyle(
                            FontWeight.w400,
                            const ColorPalette().mintCream,
                            20,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(20))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
