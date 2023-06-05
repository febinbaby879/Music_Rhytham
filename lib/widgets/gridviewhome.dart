import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class gridHome extends StatelessWidget {
  const gridHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 40.0,
          mainAxisSpacing: 30.0,
        ),
        itemBuilder: (BuildContext context, int i) {
          return Container(
            decoration: BoxDecoration(
              color: i % 2 == 1
                ? Color(0xFF399BBA)
                : Color.fromARGB(255, 149, 5, 5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(i%2==0
                                ?'assets/images/clown-listening-to-music-relaxing-35822021.jpg'
                                :'assets/images/3-nature-wallpaper-mountain.jpg'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.ellipsisVertical),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i%2==1? 'Love has never ending':'Low',overflow: TextOverflow.ellipsis,),
                          Text(i%2==1? 'Never ending love':'Zavan beats')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height: 50.0,
          );
        },
      ),
    );
  }
}
