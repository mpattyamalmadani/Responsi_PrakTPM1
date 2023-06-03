import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_praktpm/models/favorite_model.dart';
import 'package:responsi_praktpm/screens/selected_movie_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Box<Favorite> localDB = Hive.box<Favorite>("favorite_list");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: localDB.listenable(),
        builder: (BuildContext context, Box<dynamic> value, Widget? child){
          if(value.isEmpty){
            return Center(
              child: Text('Favorite Manga listing is Empty'),
            );
          }

          return Container(
              color: Colors.grey[200],
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Text(
                      'Your Favorite Manga',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: localDB.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedMovieScreen(imdbID: '${localDB.getAt(index)?.imdbID}')));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              '${localDB.getAt(index)?.imageUrl}'
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            //spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(4, 8), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 60, bottom: 20),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        //spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(4, 8), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${localDB.getAt(index)?.title}',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${localDB.getAt(index)?.synopsis}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber,),
                                          SizedBox(width: 10,),
                                          Text('${localDB.getAt(index)?.imdbRating}', style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                          ),),
                                        ],
                                      ),
                                      //SizedBox(height: 5),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: (){
                                            localDB.getAt(index)?.delete();
                                          },
                                          icon: Icon(Icons.delete_outline, color: Colors.red,),
                                        ),
                                      )
                                    ],
                                  ),

                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40,)
                ],
              )
          );
        },
      ),
    );
  }
}
