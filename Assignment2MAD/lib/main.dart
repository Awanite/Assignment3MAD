import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      theme: ThemeData.dark(),
      home: semesterBook(),
    ));
  }
}

class semesterBook extends StatefulWidget {
  @override
  _semesterBookState createState() => _semesterBookState();
}

class _semesterBookState extends State<semesterBook> {
  List semesters = [];

  // Fetch content from the json file
  Future<void> loadJSON() async {
    final String response = await rootBundle.loadString('assets/219272.json');
    final data = await json.decode(response);
    setState(() {
      semesters = data["semesters"];
    });
  }

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          actions: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://scontent.fisb5-1.fna.fbcdn.net/v/t1.6435-1/c0.0.160.160a/p160x160/74226541_2239478696342021_7572508392070053888_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=7206a8&_nc_eui2=AeFap5veGOXNBrO4XSnEac5zmE8h9HTGzgGYTyH0dMbOAfaDhcslsyIK57vwCGG5EvNQZWDPL595uJMN4mq6eGYx&_nc_ohc=CXqkw1BnqucAX-jSf3r&_nc_ht=scontent.fisb5-1.fna&tp=27&oh=0d0065b6e1b614474f685a0f27dc245f&oe=60CD4A30'),
            ),
          ],
          title: Text(
            'Muhammad Awais Adnan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            semesters.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: semesters.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[800],
                          margin: EdgeInsets.all(4),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => Course(
                                      id: semesters[index]["id"],
                                    ),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 300),
                                  ));
                            },
                            leading: Icon(
                              Icons.book_outlined,
                              color: Colors.white,
                            ),
                            title: Text(semesters[index]["name"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                )),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class Course extends StatefulWidget {
  final String id;
  const Course({this.id});

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  List courses = [];

  // Fetch content from the json file
  Future<void> loadJSON() async {
    final String response = await rootBundle.loadString('assets/207701.json');
    final data = await json.decode(response);
    var id = int.parse(widget.id);
    setState(() {
      courses = data["semesters"][id]["courses"];
    });
  }

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  var blueHighlight = [
    "Done"
  ];
  var greenHighlight = [
    "Due"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey,
          actions: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://scontent.fisb5-1.fna.fbcdn.net/v/t1.6435-1/c0.0.160.160a/p160x160/74226541_2239478696342021_7572508392070053888_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=7206a8&_nc_eui2=AeFap5veGOXNBrO4XSnEac5zmE8h9HTGzgGYTyH0dMbOAfaDhcslsyIK57vwCGG5EvNQZWDPL595uJMN4mq6eGYx&_nc_ohc=CXqkw1BnqucAX-jSf3r&_nc_ht=scontent.fisb5-1.fna&tp=27&oh=0d0065b6e1b614474f685a0f27dc245f&oe=60CD4A30')),
          ],
          title: Text(
            'Muhammad Awais Adnan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            courses.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: blueHighlight.contains(courses[index]["grade"]) ? Colors.blue : (greenHighlight.contains(courses[index]["grade"]) ? Colors.green : Colors.red),
                          // color: courses[index]["grade"] == ("A") ? Colors.blue : Colors.green,
                          shape: RoundedRectangleBorder(
                            // side: BorderSide(
                            //     color: blueHighlight
                            //             .contains(courses[index]["grade"])
                            //         ? Colors.blue
                            //         : (greenHighlight
                            //                 .contains(courses[index]["grade"])
                            //             ? Colors.green
                            //             : Colors.red),
                            //     width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(courses[index]["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                )),
                            subtitle: Text(courses[index]["grade"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
