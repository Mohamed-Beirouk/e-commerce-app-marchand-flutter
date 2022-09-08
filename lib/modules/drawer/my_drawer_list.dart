import 'package:flutter/material.dart';
import '../../layout/shop_app/shop_layout.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../styles/icon_broken.dart';
import '../shop_app/login_shop/login_screen.dart';
import '../shop_app/notification/notification_screen.dart';
import '../shop_app/settings/settings_screen.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          InkWell(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShopLayout()));
            },
            child: Padding(
                padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                      child:Icon(
                        Icons.dashboard_outlined,
                        size: 20,
                        color: Colors.brown,
                      ),

                  ),
                  Expanded(
                    flex: 3,
                    child:Text('Dashboaard',style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),)

                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),));
            },
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child:Icon(
                      IconBroken.Profile,
                      size: 25,
                      color: Colors.brown,
                    ),

                  ),
                  Expanded(
                      flex: 3,
                      child:Text('Profile',style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),)

                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotificationScreen(),));
            },
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child:Icon(
                      IconBroken.Notification,
                      size: 25,
                      color: Colors.brown,
                    ),

                  ),
                  Expanded(
                      flex: 3,
                      child:Text('Notification',style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),)

                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: ()
            {
              CacheHelper.removeData(key:'token').then((value)
              {
                navigateAndFinish(context,LoginScreen());
              });
            },
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child:Icon(
                      IconBroken.Logout,
                      size: 20,
                      color: Colors.brown,
                    ),

                  ),
                  Expanded(
                      flex: 3,
                      child:Text('Logout',style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),),
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
