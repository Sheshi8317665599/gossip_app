import 'package:flutter/material.dart';
import 'package:gossip_app/auth/auth_service.dart';
import 'package:gossip_app/components/user_tile.dart';
import 'package:gossip_app/services/chat_service.dart';

class BlockedUsersScreens extends StatelessWidget {
   BlockedUsersScreens({super.key});

   final ChatService chatService = ChatService();
   final AuthService authService = AuthService();

    void _showUnblockBox(BuildContext context, String userID){
      showDialog(context: context, builder: (context) => AlertDialog(
        title:  const Text('Unblock'),
        content: const Text('Are you sure you want to unblock this user?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("cancel"),),
          TextButton(onPressed: () {
            chatService.unblockUser(userID);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Un Blocked!")));
          }, child: const Text("UnBlock"),), 
          ],
      ));
    }
  @override
  Widget build(BuildContext context) {
    String userID = authService.getCurrentUser()!.uid;
    return Scaffold(
      appBar: AppBar(title: Text("BLOCKED USERS"),
      actions:[],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsersStream(userID),
      builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something went wrong"),
        );
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final blockedUsers = snapshot.data ?? [];

      if (blockedUsers.isEmpty) {
        return const Center(
          child: Text("No blocked users"),);
      }

      return ListView.builder(
        itemCount: blockedUsers.length,
        itemBuilder: (context, index) {
        final user = blockedUsers[index];
        return UserTile(
          text: user["email"], onTap: () => _showUnblockBox(context, user['uid']),);
      });
      },
      ),
    );
  }
}