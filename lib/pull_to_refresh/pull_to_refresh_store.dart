import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';

part 'pull_to_refresh_store.g.dart';

class PullToRefreshStore = _PullToRefreshStore with _$PullToRefreshStore;

abstract class _PullToRefreshStore with Store {
  ///Define the size of Record per page
  static const _pageSize = 10;

  ///Initialized page controller for pagination
  final PagingController<int, String> pagingController =
      PagingController(firstPageKey: 0);

  _PullToRefreshStore() {
    ///Add lister to page controller for Add new data when user scroll the page
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @observable
  bool isRefresh = false;

  @action
  Future<void> _fetchPage(int pageKey) async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));

      ///generate new 10 data
      final newItems =
          List.generate(10, (index) => isRefresh ? 'Update $index' : '$index')
              .toList();

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        ///Appends [newItems] to the previously loaded ones and sets the next page
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;

        ///Appends [newItems] to the previously loaded ones and replaces
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @action
  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (pagingController.itemList != null) {
      ///Clear all previous data from list and Recall api
      pagingController.itemList!.clear();
      _fetchPage(0);

      isRefresh = !isRefresh;
    }
  }
}
