import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gossip_app/auth/auth_service.dart';
import 'package:gossip_app/consts.dart';
import 'package:gossip_app/screens/payment_screen.dart';
import 'package:gossip_app/screens/settings_screens.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
      final _auth = AuthService();

          Future<void> _setup() async{
     Stripe.publishableKey = StripePublishablekey;
  }

    @override
  void initState() {
    super.initState();
    _setup();
  }

    void logout() {
    _auth.signOut();
  } 

  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          children: [
            // logo
         DrawerHeader(
          decoration: const BoxDecoration(
                 color: Color.fromARGB(255, 1, 50, 32,)),
             child: SizedBox(
              height: 500, 
              width: 1000, 
              child: Center(
              child: Image.asset(
              "assets/images/GOSSIP-removebg-preview.png",
              fit: BoxFit.contain,
              ),
              ),
              ),
              ),
            // menu items
               Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("H O M E"),
                leading: const Icon(Icons.home_max_outlined),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("P A Y M E N T"),
                leading: const Icon(Icons.payment_rounded),
                onTap: () {
                   Navigator.pop(context);

                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const PaymentScreen(),));
                   },
              ),
            ),

               Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: const Text("S E T T I N G S"),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreens(),));
                },
            ),
            ),
        ],
        ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                title: const Text("L O G O U T"),
                leading: const Icon(Icons.logout_rounded),
                onTap: logout,
            ),
            ),
    ],
      ),
      );
  }
}