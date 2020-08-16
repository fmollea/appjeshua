import 'package:appjeshua/src/presentation/pagesviews/profile_page_view.dart';
import 'package:appjeshua/src/presentation/presenters/base_presenter.dart';

class ProfilePresenter extends BasePresenter<ProfilePageView> {
  navToPage(String path) {
    if (isViewAttached) {
      getView().navToPage(path);
    }
  }
}
