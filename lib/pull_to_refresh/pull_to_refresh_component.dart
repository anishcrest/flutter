import 'package:common_components/pull_to_refresh/pull_to_refresh_store.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PullToRefreshComponent extends StatefulWidget {
  const PullToRefreshComponent({
    Key? key,
  }) : super(key: key);

  @override
  _PullToRefreshComponentState createState() => _PullToRefreshComponentState();
}

class _PullToRefreshComponentState extends State<PullToRefreshComponent> {
  late PullToRefreshStore pullToRefreshStore;

  /* ///Initialized page controller for pagination
  final PagingController<int, String> _pagingController = PagingController(firstPageKey: 0);
  */

  @override
  void initState() {
    pullToRefreshStore = PullToRefreshStore();

    /* ///Add lister to page controller for Add new data when user scroll the page
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });*/
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => pullToRefreshStore.onRefresh(),
      child: PagedListView<int, String>(
        pagingController: pullToRefreshStore.pagingController,
        itemExtent: 100,
        builderDelegate:
            PagedChildBuilderDelegate(itemBuilder: (context, item, index) {
          return Card(
            child: Center(
              child: ListTile(
                leading: Image.network(
                    'https://www.neappoli.com/static/media/flutterImg.94b8139a.png'),
                title: Text(
                  'Title $item',
                ),
                subtitle: Text(
                      'SubTitle$item',
                    ),
                  ),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_){
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }

}
