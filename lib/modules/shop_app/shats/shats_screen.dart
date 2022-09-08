import 'package:flutter/material.dart';
import 'package:supper/modules/shop_app/shats/chat_detail_screen.dart';

class ShatScreen extends StatelessWidget {
  const ShatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder:(context,index) =>buildChatItem(context),
        separatorBuilder: (context,index)
        {
        return Divider();
        },
        itemCount: 10
    );
  }
  Widget buildChatItem(context) => InkWell(
    onTap: ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(),
      ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/Snapchat-131876016.jpg'),
          ),
          SizedBox(
            width: 11,
          ),
          Text(
            'Hademin sidi yahya',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )

        ],
      ),
    ),
  );
}
