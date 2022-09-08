import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  Color color = Colors.cyan,
  double width = 250,

  required Function function,
  required String text,
}) =>
    Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: MaterialButton(
            minWidth:width,
            height: 50,
            color: color,
            onPressed: () {
              function();
            },
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

Widget defaultButtonL({
  Color ?color ,
  double width = 220,
  double height = 60,

  required Function function,
  required String text,
}) =>
    Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(30),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: MaterialButton(
            minWidth:width,
            height: 60,
            color: color,
            onPressed: ()
            {
              function();
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

Widget defaultTextField({
  required TextEditingController controller,
  bool isPassword = false,
  bool isClickable = true,
  required TextInputType type,
  Function? onSubmit,
  Function? onTap,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function? suffixFunction,
  String textForUnValid = 'this element is required',
  //required Function validate,
}) =>
    Container(
      height: 80,
      decoration: BoxDecoration(),
      child: TextFormField(
        enableSuggestions: true,
        autocorrect: true,
        controller: controller,
        enabled: isClickable,
        onTap: () {
          onTap!();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return textForUnValid;
          }
          return null;
        },
        onChanged: (value) {},
        onFieldSubmitted: (value) {
          onSubmit!(value);
        },
        obscureText: isPassword ? true : false,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: () {
              suffixFunction!();
            },
            icon: Icon(suffix),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: const BorderSide(),
              gapPadding: 4),
        ),
      ),
    );


Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
 // required Function validate,
  required String hint,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  String textForUnValid = 'this element is required',
  Function? suffixPressed,
})=>TextFormField(
controller: controller,
keyboardType:  type,
obscureText: isPassword,
//   validator: (String? value) {
//     if (value!.isEmpty) {
//       return 'this element is required';
//     }
//     return null;
//   },
onChanged: (value){
  onChange!(value);
},
onFieldSubmitted:(value){
  onSubmit!(value);
},
decoration: InputDecoration(
hintText: hint,
prefixIcon:Icon(
    prefix,
),
suffixIcon:IconButton(
  onPressed:(){
    suffixPressed!();
},
    icon: Icon(suffix),
),
border: OutlineInputBorder(),
),
);

Widget buildArticleItem() =>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width:120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image:DecorationImage(
            image: NetworkImage('https://resetapp.com.au/img/phoneimage.png'),
            fit:BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '12000UM',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

void navigateAndFinish(
    context,widget) =>
    Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
    builder:(context) => widget),
      (route)
      {
        return false;
      } ,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>  Fluttertoast.showToast
  (
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: shoosToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates{SUCCESS, ERROR, WARNING}

Color shoosToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}