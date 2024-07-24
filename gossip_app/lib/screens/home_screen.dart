import 'package:flutter/material.dart';
import 'package:gossip_app/auth/auth_service.dart';
import 'package:gossip_app/components/my_drawer.dart';
import 'package:gossip_app/components/user_tile.dart';
import 'package:gossip_app/screens/chat_screen.dart';
import 'package:gossip_app/services/chat_service.dart';
import 'package:gossip_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
               ),
               drawer: const MyDrawer(),
               
               body: _buildUerList(),
     ),
      );
    }

  Widget _buildUerList(){
    return StreamBuilder(
      stream: _chatService.getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("loading...");
      }

      return ListView(
        children: snapshot.data!
        .map<Widget>((UserData) => _buildUerListItem(UserData, context))
        .toList(),
      );
      }
  );}

  Widget _buildUerListItem(Map<String, dynamic> userData, BuildContext context){
    if (userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
          context,
           MaterialPageRoute(
            builder: (context)=>  ChatScreen(
          receiverEmail: userData["email"],
          receiverID: userData["uid"],
          


        ),
        ),
        );
      },
    );
    }else {
      return Container();
    }

  }
}
