import 'package:flutter/material.dart';
import 'package:supper/styles/icon_broken.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/Snapchat-131876016.jpg'),
            ),
            SizedBox(
              width: 11,
            ),
            Text(
              'Hademin sidi yahya',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  ),
                ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(
                      'hello 7ademin',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(180, 182, 252, 249),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Text(
                  'hello 7ademin',
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ),
            ),
           Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12
                ),
                borderRadius: BorderRadius.circular(15.0)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type your message here...',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                   width: 15,
                  ),
                  Container(
                    color: Colors.black12,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1.0,
                    child: Icon(
                      IconBroken.Send,
                      size:16 ,
                      color: Colors.black,
                    ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
