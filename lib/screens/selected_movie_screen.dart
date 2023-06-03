import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_praktpm/models/favorite_model.dart';
import 'package:responsi_praktpm/providers/movie_network.dart';
import 'package:responsi_praktpm/models/detail_model.dart';
import 'package:url_launcher/url_launcher.dart';


class SelectedMovieScreen extends StatefulWidget {
  final imdbID;
  const SelectedMovieScreen({Key? key, required this.imdbID}) : super(key: key);

  @override
  State<SelectedMovieScreen> createState() => _SelectedMovieScreenState();
}

class _SelectedMovieScreenState extends State<SelectedMovieScreen> with TickerProviderStateMixin{

  Box<Favorite> localDB = Hive.box<Favorite>("favorite_list");
  bool _isFavorite = false;
  var _indexFavorite = 0;
  String _launchUrl = 'https://www.google.com';


  Future<void> _launchInBrowser(String url) async{
    if(await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);


    return FutureBuilder<DetailModel>(
      future: getDetail(widget.imdbID),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){

          for(var i = 0; i < localDB.length; i++){
            if(localDB.getAt(i)?.imdbID == snapshot.data?.movie?.imdbID){
              _isFavorite = true;
              _indexFavorite = i;
            }
          }
          return Scaffold(
            bottomNavigationBar: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25,bottom: 12, top: 8),
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blueGrey,
                      )
                  ),
                  child: IconButton(
                    icon:  Icon( _isFavorite ? Icons.favorite : Icons.favorite_border_outlined, color: Colors.red,),
                    onPressed: (){
                      setState(() {
                        if(!_isFavorite){
                          //localDB.add(Favorite(imdbID: snapshot.data?.movie?.imdbID, title: snapshot.data?.movie?.title, url: snapshot.data?.movie?.website, imageUrl: snapshot.data?.movie?.poster?.imageUrl, synopsis: snapshot.data?.movie?.plot, imdbRating: snapshot.data?.movie?.imdbRating));
                          _isFavorite = true;
                        }else{
                          localDB.getAt(_indexFavorite)?.delete();
                          _isFavorite = false;
                        }
                        //_isFavorite = !_isFavorite;
                        debugPrint('$_isFavorite');
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 12, left: 20, right: 25),
                    height: 49,
                    color: Colors.transparent,
                    child: TextButton(
                      onPressed: () async {
                        //String url = '${snapshot.data?.url}';

                        _launchUrl = '${snapshot.data?.movie?.website}';
                        _launchInBrowser(_launchUrl);
                      },
                      style: TextButton.styleFrom(
                        // primary: Colors.purpleAccent,
                        backgroundColor: Colors.purpleAccent,
                      ),
                      child: Text(
                        'Go to Website',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.blueGrey,
                      expandedHeight: MediaQuery.of(context).size.height*0.5,
                      flexibleSpace: Container(
                        height: MediaQuery.of(context).size.height*0.5,
                        color: Colors.white24,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 70),
                                width: 172,
                                height: 225,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //image:  DecorationImage(
                                       // image: NetworkImage('${snapshot.data?.movie?.poster?.imageUrl}')
                                    //)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SliverList(
                        delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding: EdgeInsets.only(top: 24, left: 25),
                                child: Text('${snapshot.data?.movie?.title}', style: TextStyle(
                                    fontSize: 27,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7, left: 25),
                                child: Text('${snapshot.data?.movie?.genre}', style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7, left: 25),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 40,),
                                    SizedBox(width: 15,),
                                    Text('${snapshot.data?.movie?.imdbRating}', style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('(${snapshot.data?.movie?.imdbVotes})', style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                height: 28,
                                margin: EdgeInsets.only(top: 23, bottom: 25),
                                padding: EdgeInsets.only(left: 25),
                                child: TabBar(
                                  controller: _tabController,
                                  // labelPadding: EdgeInsets.all(0),
                                  // indicatorPadding: EdgeInsets.all(0),
                                  isScrollable: true,
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),

                                  tabs: [
                                    Tab(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 39),
                                        child: Text('Detail'),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 39),
                                        child: Text('Synopsis'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                height: MediaQuery.of(context).size.height,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Status', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.runtime}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Rank', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.metascore}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Published', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.released}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Members', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('(${snapshot.data?.movie?.actors})', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Volumes', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.genre}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Chapters', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.production}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Popularity', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.ratings}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text('Favorites', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Text('${snapshot.data?.movie?.rated}', style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        )
                                    ),
                                    Container(
                                        child: Text('${snapshot.data?.movie?.plot}', style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          letterSpacing: 1.5,
                                          height: 2,),
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
            ),
          );

        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}