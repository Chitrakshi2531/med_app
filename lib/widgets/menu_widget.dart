import 'package:flutter/material.dart';
class MenuWidget extends StatelessWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFFE0E0E0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/user_profile.jpg'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'xyz',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                   ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          sliderItem('Dashboard', Icons.dashboard_outlined),
          sliderItem('Equipments', Icons.add_to_photos_outlined),
          sliderItem('Request',Icons.list_alt_outlined),
          sliderItem('Feedback', Icons.feedback_outlined),
          sliderItem('About', Icons.article_outlined),
          sliderItem('Setting', Icons.settings),
          sliderItem('LogOut', Icons.arrow_back_ios)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => InkWell(
    child: SizedBox(
      height: 40,
      child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
          children: [
            Icon(icons,color:Colors.black54,size: 18,),
            const SizedBox(width: 10,),
            Text(title,style: const TextStyle(color: Colors.black54, fontSize: 16),)
          ],
        ),
      ),
    ),
    onTap: () {
      onItemClick!(title);
    }

  );


}