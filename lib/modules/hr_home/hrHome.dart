// @dart=2.9
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class HrHome extends StatelessWidget {
  const HrHome({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 160.0,
        backgroundColor: defaultColor,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Padding(
              child: Row(children: [
                Text('Hi, ${CacheHelper.getData(key: 'name')}!'),
              ], crossAxisAlignment: CrossAxisAlignment.center),
              padding: EdgeInsets.only(left: 5, right: 5, top: 20)),
        ),
      ),
      SliverPadding(padding: EdgeInsets.only(top: 10)),
      SliverToBoxAdapter(
          child: defaultFormField(
              controller: searchController,
              type: TextInputType.emailAddress,
              label: 'Search',
              prefix: Icons.search,
              suffix: Icons.sort)),
      SliverPadding(
        padding: EdgeInsets.only(top: 10),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
              onTap: () {},
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: const [
                      Image(
                        image: NetworkImage(
                            'https://cdn.searchenginejournal.com/wp-content/uploads/2017/06/shutterstock_268688447-760x400.webp'),
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Senior flutter developer',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: SizedBox(
                        width: double.infinity / 2,
                        child: Text(
                            'dkfkrorforkfor kvfmmvkfmvkfmvkfmv vmfvkfkgtbtkm ktgmtrkgmtkgmgt glgktlrkgtlrgk gktgktk kforkforkforkfrokforkfor' +
                                ' ...'),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
