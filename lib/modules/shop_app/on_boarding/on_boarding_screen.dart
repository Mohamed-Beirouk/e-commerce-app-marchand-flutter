import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supper/modules/shop_app/login_shop/login_screen.dart';
import 'package:supper/styles/colors.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding =
  [
    BoardingModel(
      image: 'assets/images/on1.png',
      title: 'On Bord 1 Title',
      body: 'On board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/on2.png',
      title: 'On Bord 2 Title',
      body: 'On board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/on3.png',
      title: 'On Bord 3 Title',
      body: 'On board 3 Body',
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          TextButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

              }, child: Text(
            'SKIP',
            style: TextStyle(
              color: Colors.green.withOpacity(0.7),
            ),
          ),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState((){
                      isLast = true;
                    });

                  }else
                  {
                    setState((){
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]) ,
              itemCount: boarding.length,

              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    activeDotColor: Colors.green.withOpacity(0.7),
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }else
                    {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                    child:Icon(
                      Icons.arrow_forward_ios,
                    ),),
              ],
            )
          ]
          ,
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
