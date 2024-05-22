import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../blocs/search_bloc.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState()=> SearchScreenState();
}
class SearchScreenState extends State<SearchScreen>{
  TextEditingController searchController = TextEditingController();
  bool _showClearSearch = false;
  @override
  // void initState() {
  //   super.initState();
  //   final searchBloc = context.read<SearchBloc>();
  //   // Set up listeners here
  //   context.read<SearchBloc>().textFieldCtrl.addListener(() {
  //     if(mounted){
  //       setState(() {
  //         _showClearSearch = searchBloc.textFieldCtrl.text.isNotEmpty;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
    // final sp = context.watch<SearchBloc>();
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     surfaceTintColor: Colors.white,
    //     title: TextField(
    //       cursorColor: const Color(0xff175349),
    //       controller: context.watch<SearchBloc>().textFieldCtrl,
    //       decoration: InputDecoration(
    //         enabledBorder: OutlineInputBorder(
    //           borderSide: const BorderSide(width: 1.8,color: Colors.grey),
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         focusedBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: const BorderSide(width: 1.8,color: Color(0xff175349))
    //         ),
    //         contentPadding: const EdgeInsets.all(10),
    //         prefixIcon: const Icon(Icons.search,color: Colors.grey,),
    //         hintText: "Search Title, Author, Topic, Other",
    //         hintStyle: const TextStyle(fontSize: 15,color: Colors.grey),
    //         suffixIcon: _showClearSearch? IconButton(
    //           onPressed: (){
    //             setState(() {
    //               context.read<SearchBloc>().searchInitialise();
    //             });
    //           },
    //           icon: const Icon(Icons.close,size: 22,),
    //         ): null,
    //       ),
    //       textInputAction: TextInputAction.search,
    //       onSubmitted: (value){
    //         if(value == ''){
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content: Container(
    //                 alignment: Alignment.centerLeft,
    //                 height: 60,
    //                 child: const Text(
    //                   'Type something!',
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                   ),
    //                 ),
    //               ),
    //               action: SnackBarAction(
    //                 label: 'Ok',
    //                 textColor: Colors.blueAccent,
    //                 onPressed: () {},
    //               ),
    //             ),
    //           );
    //         }else {
    //           context.read<SearchBloc>().setSearchText(value);
    //           context.read<SearchBloc>().addToSearchList(value);
    //         }
    //       },
    //     ),
    //     toolbarHeight: 80,
    //     bottom: PreferredSize(
    //       preferredSize: const Size.fromHeight(46),
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
    //         child: Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text(
    //             context.watch<SearchBloc>().searchStarted == false ? "Recent searches" : "We have found"
    //             , style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),),
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 14),
    //       child: context.watch<SearchBloc>().searchStarted == false ?
    //       sp.recentSearchData.isEmpty ?
    //       ListView(
    //         children: [
    //           const SizedBox(height: 50,),
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width,
    //             child: const EmptyPage(icon: FontAwesomeIcons.search, message: 'Search News', message1: 'You haven\'t search for any items yet.\nTry now - we will help you!'),
    //           ),
    //         ],
    //       ) :
    //       ListView.separated(
    //           itemBuilder: (context, index){
    //             return Container(
    //               decoration: BoxDecoration(
    //                   color: Colors.grey[200],
    //                   borderRadius: BorderRadius.circular(10)
    //               ),
    //               child: ListTile(
    //                 title: Text(sp.recentSearchData[index],style: const TextStyle(fontSize: 17),),
    //                 leading: Icon(
    //                   Icons.watch_later_outlined,
    //                   color: Colors.grey[400],
    //                 ),
    //                 trailing: IconButton(
    //                   icon: const Icon(Icons.delete),
    //                   onPressed: () {
    //                     sp.removeFromSearchList(sp.recentSearchData[index]);
    //                   },
    //                 ),
    //                 onTap: (){
    //                   sp.setSearchText(sp.recentSearchData[index]);
    //                 },
    //               ),
    //             );
    //           },
    //           separatorBuilder: (context, index){
    //             return const SizedBox(height: 10,);
    //           },
    //           itemCount: sp.recentSearchData.length
    //       ) :
    //       FutureBuilder(
    //         future: context.watch<SearchBloc>().getData(),
    //         builder: (BuildContext context, AsyncSnapshot snapshot){
    //           if(snapshot.hasData){
    //             if(snapshot.data.length == 0) {
    //               return SizedBox(
    //                   width: MediaQuery.of(context).size.width,
    //                   child: const Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       FaIcon(FontAwesomeIcons.clipboard,size: 92,color: Colors.grey,),
    //                       SizedBox(height: 10,),
    //                       Text('No articles found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black87),),
    //                       Text('Try again!',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey),),
    //                     ],
    //                   )
    //               );
    //             }
    //             else {
    //               return GridView.builder(
    //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 2,
    //                   mainAxisSpacing: 10,
    //                   crossAxisSpacing: 14,
    //                 ),
    //                 itemBuilder: (context, index) {
    //                   return InkWell(
    //                     onTap: (){
    //                       navigateToDetailsScreen(context, snapshot.data[index], 'search${snapshot.data[index].timestamp}');
    //                     },
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(10),
    //                         border: Border.all(width: 1,
    //                             color: Colors.grey.withOpacity(.6)),
    //                         color: Colors.white,
    //                       ),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           ClipRRect(
    //                             borderRadius: const BorderRadius.only(
    //                                 topLeft: Radius.circular(10),
    //                                 topRight: Radius.circular(10)),
    //                             child: Hero(
    //                               tag: 'search${snapshot.data[index].timestamp}',
    //                               child: CachedNetworkImage(
    //                                 imageUrl: snapshot.data[index].thumbnailImagelUrl,
    //                                 fit: BoxFit.cover,
    //                                 height: 96,
    //                                 width: MediaQuery.of(context).size.width,
    //                                 placeholder: (context, url) => Container(color: Colors.grey[300]),
    //                                 errorWidget: (context, url, error) => Container(
    //                                   color: Colors.grey[300],
    //                                   child: const Icon(Icons.error),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(
    //                                 left: 8, right: 8, top: 4, bottom: 0),
    //                             child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Text(snapshot.data[index].title,
    //                                   overflow: TextOverflow.ellipsis,
    //                                   maxLines: 2,
    //                                   style: const TextStyle(
    //                                       fontWeight: FontWeight.w500,
    //                                       fontSize: 14
    //                                   ),
    //                                 ),
    //                                 const SizedBox(height: 6,),
    //                                 Row(
    //                                   children: [
    //                                     const Icon(FontAwesomeIcons.clock,
    //                                       color: Colors.grey, size: 14,),
    //                                     const SizedBox(width: 6,),
    //                                     Text(snapshot.data[index].date, style: const TextStyle(
    //                                         fontSize: 14, color: Colors.grey),)
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   );
    //                 }, itemCount: snapshot.data.length,
    //               );
    //             }
    //           }
    //           return const Center(child: Text('Loading...'),);
    //         },
    //       ),
    //   ),
    // );
  }
}