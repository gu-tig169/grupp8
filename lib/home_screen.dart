import 'package:flutter/material.dart';
import 'aboutUs_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final List<String> _listItem = [
  'assets/images/chewy1.jpg',
  'assets/images/chewy2.jpg',
  'assets/images/chewy3.jpg',
  'assets/images/chewy4.jpg',
  'assets/images/chewy1.jpg',
  'assets/images/chewy2.jpg',
  'assets/images/chewy3.jpg',
  'assets/images/chewy4.jpg',
];

final TextEditingController imageSearch = new TextEditingController();

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: <Widget>[
//         Container(
//           color: Color.fromARGB(255, 86, 75, 83),
//         ),
//         Positioned(
//           child: AppBar(backgroundColor: Colors.transparent, actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.info),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => (AboutUs())),
//                 );
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.person),
//               onPressed: () {},
//             )
//           ]),
//         ),
//       ],
//     ));
//   }
// }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 75, 83),
      appBar: _appBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _topImage(),
              SizedBox(
                child: (
                  _searchImageTextField()
                ),
                height: 60,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _listItem
                    .map((item) => Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover)),
                            child: Transform.translate(
                              offset: Offset(65, -65),
                              child: Container(
                                
                                margin: EdgeInsets.symmetric(
                                    horizontal: 64, vertical: 64),
                                child: IconButton(
                                  icon: Icon(Icons.favorite_border,
                                  color: Colors.black),
                                                                   
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (AboutUs())),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ]
      );
  }

  Widget _topImage() {
    return Container(
          width: double.infinity,
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                  image: AssetImage('assets/images/chewy1.jpg'),
                  fit: BoxFit.cover)),
            child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight, 
                        colors: [
                          Colors.black.withOpacity(.4),
                          Colors.black.withOpacity(.2),
                        ]
                      ),
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            "Chewy by the lake",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                      ),
                    ],
                  ),
              ),
      );
  }

  Widget _searchImageTextField() {
    return Container(
        margin: EdgeInsets.only(
          left: 1,
          right: 1,
          top: 10,
          bottom: 10
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          controller: imageSearch,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search,
            color: Colors.white),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30, width: 2)),
              hintText: "Search..",

              hintStyle: TextStyle(
                fontSize: 20
              )),
        )
      );
}
}