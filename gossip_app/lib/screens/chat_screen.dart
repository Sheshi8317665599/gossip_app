import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gossip_app/auth/auth_service.dart';
import 'package:gossip_app/components/my_textfeild.dart';
import 'package:gossip_app/screens/chat_bubble.dart';
import 'package:gossip_app/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

   ChatScreen({
  super.key,
  required this.receiverEmail,
  required this.receiverID,
   
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController =TextEditingController();

   final ChatService _chatService = ChatService();

   final AuthService _authService = AuthService();

   FocusNode myFocusNode = FocusNode();

   @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500),
        () => scrollDown(),
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 500), 
    () => scrollDown(),);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
       duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        );
  }

   void sendMessage() async{
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
        _messageController.clear();
    }

    scrollDown();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('receivedEmail'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
               ),
        body: Column(
          children:[
          Expanded(
            child: _buildMessageList(),
            ),

            _buildUserInput(),
          ],
          ),
      );
  }

  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting)  {
           return const  Text("loading...!");
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var aligment = 
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment: 
        
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
           isCurrentUser: isCurrentUser,
           messageID: doc.id,
           userID: data['senderID'],
           ),
        ],
      ));
  }

  Widget _buildUserInput(){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfeild(
              hintText: "Type a message",
               obscureText: false,
               focusNode: myFocusNode,
                 controller: _messageController, icon: const Icon(Icons.hd), 
                 ),
                 ),
      
                 Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape:BoxShape.circle,
                  ),
                   child: IconButton(onPressed: sendMessage,
                    icon:const Icon(Icons.arrow_outward_outlined),
                   ),
                 ),
        ],
      ),
    );
  }
}