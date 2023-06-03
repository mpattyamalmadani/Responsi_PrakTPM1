import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsi_praktpm/models/home_data_model.dart';
import 'package:responsi_praktpm/providers/movie_network.dart';
import 'package:responsi_praktpm/screens/search_screen.dart';
import 'package:responsi_praktpm/screens/selected_movie_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //final _searchController = TextEditingController();
  //String _querySearch = "";
  int _selectedIndex = 0;
  String _category = "manga";


  late Future<HomeDataModel> _loadManga;

  Widget _buttonBuilder(String name, int myIndex, String category){
    return GestureDetector(
      onTap: (){
        setState(() {
          _selectedIndex = myIndex;
          _category = category;
        });
      },
      child: FittedBox(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
          decoration: BoxDecoration(
            color: _selectedIndex == myIndex ? Colors.blueGrey : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: .8,
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: _selectedIndex == myIndex ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Mangangers',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey
                      ),
                    ),
                    Text(
                      'Explore Manga',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),

              //search field
              // Container(
              //   height: 39,
              //   margin: EdgeInsets.only(left: 25, right: 25, top: 18),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         //spreadRadius: 5,
              //         blurRadius: 7,
              //         offset: Offset(4, 8), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: Stack(
              //     children: [
              //       TextField(
              //         maxLengthEnforced: true,
              //         style: GoogleFonts.openSans(
              //             fontSize: 12,
              //             color: Colors.black,
              //             fontWeight: FontWeight.w600
              //         ),
              //         decoration: InputDecoration(
              //           contentPadding: EdgeInsets.only(left: 19, right: 50,bottom: 8),
              //           border: InputBorder.none,
              //           hintText: 'Search manga...',
              //           hintStyle: GoogleFonts.openSans(
              //               fontSize: 12,
              //               color: Colors.grey,
              //               fontWeight: FontWeight.w600
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //           right: 0,
              //           child: GestureDetector(
              //             onTap: (){
              //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
              //             },
              //             child: Container(
              //               width: 39,
              //               height: 39,
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: Colors.amber
              //               ),
              //             ),
              //           )
              //       ),
              //       Positioned(
              //           top: 8,
              //           right: 9,
              //           child: GestureDetector(
              //             onTap: (){
              //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
              //             },
              //             child: Icon(
              //                 Icons.search
              //             ),
              //           )
              //       )
              //     ],
              //   ),
              // ),

              Container(
                height: 25,
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(left: 25),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buttonBuilder('Top', 0, 'manga'),
                    _buttonBuilder('Novels', 1, 'novels'),
                    _buttonBuilder('Oneshots', 2, 'oneshots'),
                    _buttonBuilder('Manhwa', 3, 'manhwa'),
                    _buttonBuilder('Manhua', 4, 'manhua'),
                  ],
                ),
              ),

              FutureBuilder<HomeDataModel>(
                future: getHomeData(category: _category),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot, ){
                  if(snapshot.hasError){
                    return Center(child: Text("$_category"+ snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
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
                                              '${snapshot.data.mmovie[index].images.jpg.imageUrl}',
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
                                          '${snapshot.data.movie[index].title}',
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
                                          '${snapshot.data.movie[index].startDate} - ${snapshot.data.manga[index].endDate == null ? "unknown" : snapshot.data.manga[index].endDate}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.amber,),
                                            SizedBox(width: 10,),
                                            Text('${snapshot.data.movie[index].score}', style: TextStyle(
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
                    );

                    //   Container(
                    //   margin: EdgeInsets.only(top: 21),
                    //   height: 210,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.only(left: 25, right: 6),
                    //     physics: BouncingScrollPhysics(),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: snapshot.data.manga.length,
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //         onTap: (){
                    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedMangaScreen(malId: '${snapshot.data.manga[index].malId}')));
                    //         },
                    //         child: Container(
                    //             margin: EdgeInsets.only(right: 19),
                    //             height: 210,
                    //             width: 153,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               color: Colors.blueGrey,
                    //               image: DecorationImage(
                    //                 image: NetworkImage('${snapshot.data.manga[index].imageUrl}'),
                    //               ),
                    //             )
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // );
                  } else {
                    return _buildLoadingSection();
                  }
                },
              ),

              SizedBox(height: 30,)

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLoadingSection() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 150),
          child: CircularProgressIndicator()
      ),
    );
  }


}
