import 'package:flutter/material.dart';
import 'package:hngstage2_0/UI/inventory_page.dart';

class NavBar  extends StatelessWidget {

  const NavBar ({super.key});



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              accountName: const Text('Welcome Back',
                style:
                TextStyle(color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              accountEmail:  Text("Inventory Manager",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Center(
                    child:
                    Image.asset(
                        'assets/ads 2.jpg',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                    ))),
              ),
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                //image: DecorationImage(image: AssetImage('assets/ads 2.jpg'), fit: BoxFit.cover)
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const InventoryPage()));
            },
          ),
          SizedBox(height: 600,),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Log Out'),
            onTap: (){

            },
          ),
        ],
      ),
    );

  }
}
