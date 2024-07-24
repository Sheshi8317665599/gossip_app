import 'package:flutter/material.dart';
import 'package:gossip_app/services/chat_service.dart';
import 'package:gossip_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageID;
  final String userID;

  const ChatBubble({
    super.key,
   required this.message,
   required this.isCurrentUser,
   required this.messageID,
   required this.userID,
   });

   void _ShowOptions(BuildContext context, String messageId, String userId){
    showModalBottomSheet(context: context, builder: (context){
      return SafeArea(child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title:const Text("Report"),
            onTap: () { Navigator.pop(context);
            _reportMessage(context, messageID,userID);
            },
          ),

          ListTile(
            leading: const Icon(Icons.cancel),
            title:const Text("Cancel"),
            onTap: () => Navigator.pop(context),
          ),

          ListTile(
            leading: const Icon(Icons.block),
            title:const Text("Block User"),
            onTap: () {
               Navigator.pop(context);
              _blockUser(context, userID);
            },
          ),
        ],)

      );
    });
   }

     void _reportMessage(BuildContext context, String messageID, String userID){
      showDialog(
        context: context,
         builder: (context) => AlertDialog(
        title: const Text("Report Message"),
        content: const Text("Are you sure you want to report this message?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
             child: const Text("Cancel"),
          ),
            TextButton(
            onPressed: () {
              ChatService().reportUser(messageID, userID);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Message Reported")));
            },
             child: const Text("Report"),
          ),
        ],
      ),
      );
     }

     // block user
       void _blockUser(BuildContext context, String userID){
      showDialog(
        context: context,
         builder: (context) => AlertDialog(
        title: const Text("Block User"),
        content: const Text("Are you sure you want to block this User?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
             child: const Text("Cancel"),
          ),
            TextButton(
            onPressed: () {
              ChatService().blockUser( userID);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Blocked!")));
            },
             child: const Text("Block"),
          ),
        ],
      ),
      );
     }


  @override
  Widget build(BuildContext context) {
    bool isDakMode =
     Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return GestureDetector(
      onLongPress: () {
        if(!isCurrentUser){

          _ShowOptions(context, messageID, userID);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser
           ?(isDakMode ?  Colors.grey.shade600: Colors.grey.shade500)
           :(isDakMode ?  Colors.grey.shade900: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical:15, horizontal: 25),
        child:
        Text(message, style: TextStyle(color:isCurrentUser
        ?Colors.white
        : (isDakMode ?Colors.white: Colors.black),),
        ),
      ),
    );
  }    
  }
