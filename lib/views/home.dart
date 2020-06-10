import 'package:blogapp/services/crud.dart';
import 'package:blogapp/views/create_blog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  Stream blogstream;


  Widget BlogsList() {
    return Container(
      child: StreamBuilder(
                  stream: blogstream,
                  builder: (context, snapshot) {
                    return snapshot.data==null ? Container() : ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return BlogsTile(
                            imgUrl:
                                snapshot.data.documents[index].data["imgUrl"],
                            title: snapshot.data.documents[index].data["title"],
                            desc: snapshot.data.documents[index].data["desc"],
                            authername: snapshot
                                .data.documents[index].data["autherName"],
                          );
                        });
                  },
                ),
    );
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogstream = result;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlogsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, desc, authername;

  BlogsTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.authername});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 16, left: 15),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imgUrl , width: MediaQuery.of(context).size.width -30
              , fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(title ,style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600),),
                SizedBox(height: 4,),
                Text(desc,style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w400)),
                SizedBox(height: 4,),
                Text(authername,style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
