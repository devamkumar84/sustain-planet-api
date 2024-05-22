import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Future showArticlePreview(
    context,
    String? title,
    String? description,
    String? thumbnailUrl,
    int? loves,
    String source,
    String? date,
    String? category,
    String? contentType,
    String? youtubeUrl) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                        // height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                            imageUrl: thumbnailUrl!,
                          placeholder: (context, url) => Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),)),
                    contentType == 'image'
                        ? Container()
                        : InkWell(
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_circle,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        // AppService().openLink(context, youtubeUrl!);
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 20,
                      child: CircleAvatar(
                        child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              category!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // TextButton.icon(
                          //     style: buttonStyle(Colors.grey[200]),
                          //     onPressed: () async {
                          //       // AppService().openLink(context, source);
                          //     },
                          //     icon: Icon(
                          //       Icons.link,
                          //       color: Colors.grey[900],
                          //     ),
                          //     label: Text(
                          //       'Source Url',
                          //       style: TextStyle(color: Colors.grey[900]),
                          //     ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        title!,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                        height: 3,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.favorite, size: 16, color: Colors.grey),
                          Text(
                            loves.toString(),
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          Text(
                            date!,
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // HtmlBodyWidget(htmlDescription: description!),
                      Text(description!),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
}