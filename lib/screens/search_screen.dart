import 'package:flutter/material.dart';
import 'package:responsi_praktpm/models/search_result_model.dart';
import 'package:responsi_praktpm/providers/movie_network.dart';
import 'package:responsi_praktpm/screens/selected_movie_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  late String _querySearch = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: !_isSearching
            ? Text(
          'Search Manga',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        )
            : TextField(
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
          controller: _searchController,
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.amber,),
            hintText: "Search Manga Here",
            hintStyle:TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w600
            ),
          ),
          onEditingComplete: (){
            setState(() {
              _querySearch = _searchController.text;
            });
          },
        ),
        actions: [
          _isSearching
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                this._isSearching = !this._isSearching;
                _querySearch = "";
              });
            },
          )
        ],
      ),
      body: SafeArea(
          child: _querySearch == ""
              ? Container()
              : FutureBuilder<SearchResultModel>(
            future: getSearchResultData(_querySearch),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot, ){
              if(snapshot.hasError){
                return Center(child: Text('Oops!, Something went error'),);
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Text(
                        "Search result for \"$_querySearch\"",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.manga.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedMovieScreen(imdbID: '${snapshot.data.manga[index].imdbID}')));
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
                                              '${snapshot.data.manga[index].images.jpg.imageUrl}',
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
                                      // Align(
                                      //   child: Image.network(
                                      //       '${snapshot.data.manga[1].imageUrl}',
                                      //   ),
                                      // )
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
                                          '${snapshot.data.manga[index].title}',
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
                                          '${snapshot.data.manga[index].synopsis == "" ? "(Nothing Synopsis)" : snapshot.data.manga[index].synopsis}',
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
                                            Text('${snapshot.data.manga[index].score}', style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                            ),),
                                          ],
                                        ),
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
                  ],
                );
              } else {
                return _buildLoadingSection();
              }
            },
          )

      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}