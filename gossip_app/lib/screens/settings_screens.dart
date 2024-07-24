import 'package:flutter/material.dart';
import 'package:gossip_app/screens/blocked_users_screens.dart';
import 'package:gossip_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreens extends StatelessWidget {
  const SettingsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
               ),
               body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                 child: Column(
                   children: [
                    // dark mode
                     Container(
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: const EdgeInsets.all(25),
                      padding: const EdgeInsets.all(16),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const Text("Dark Mode"),
                       
                       Switch(
                        value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                        onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                       ),
                       
                       // blocked user
                            Container(
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: const EdgeInsets.all(25),
                      padding: const EdgeInsets.all(16),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const Text("Block Users"),
                       
                       // button to go to blocked user page
                       IconButton(onPressed: () => Navigator.push(context,
                       MaterialPageRoute(builder: (context) =>  BlockedUsersScreens())),
                        icon: Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary,),),
                       
                       ],),
                     ),
                       ],),
                     ),
                   ],
                 ),
               ),
    ),
    );
  }
}