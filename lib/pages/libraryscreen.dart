import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/category_bloc.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../utils/skeleton_loading.dart';
import 'category_details.dart';

class LibraryScreen extends StatefulWidget{

  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState()=> LibraryScreenState();
}
class LibraryScreenState extends State<LibraryScreen>{
  @override
  void initState() {
    super.initState();
    // context.read<CategoryBloc>().cateData.isNotEmpty ? print('data already loaded'):
    // context.read<CategoryBloc>().getCateData();
  }
  @override
  Widget build(BuildContext context) {
    final cl = context.watch();
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Category List', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
              IconButton(
                  onPressed: ()async{
                    context.read().onCateRefresh();
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh Categories',
              )
            ],
          )
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            // context.read<CategoryBloc>().onCateRefresh();
          },
          child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.only(left: 14,right: 14,top: 16),
            child: cl.hasCateData == false ?
            ListView(
              children: const [
                SizedBox(
                  height: 300,
                  child: Center(
                    child: EmptyPage(icon: Icons.article, message: 'No Category Found', message1: '')
                  ),
                ),
              ],
            )    :
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  mainAxisExtent: 110,
                ),
                itemBuilder: (context, index){
                  if(cl.cateData.length > index){
                    return InkWell(
                      onTap: (){
                        // nextScreen(context, CategoryDetail(category: cl.cateData[index].name, categoryImage: cl.cateData[index].thumbnailUrl, tag: 'cate${cl.cateData[index].timestamp}'));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Hero(
                                tag: 'cate${cl.cateData[index].timestamp}',
                                child: CachedNetworkImage(
                                  imageUrl: cl.cateData[index].thumbnailUrl,
                                  fit: BoxFit.cover,
                                  height: 110,
                                  width: MediaQuery.of(context).size.width,
                                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                            Positioned(
                              top: 14,
                              left:14,
                              child: Text(cl.cateData[index].name,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if(cl.isCateLoading){
                    return SkeletonLoading(height: 110, color: Colors.grey[300]);
                  }
                  return Container();
                },itemCount: cl.cateData.length != 0 ? cl.cateData.length + 1 : 12),
          ),
        ),
      ),
    );
  }
}