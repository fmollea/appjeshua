class BasePresenter<T> {
  T _view;
  void attachView(T view) {
    this._view = view;
  }

  void detachView() {
    this._view = null;
  }

  bool get isViewAttached {
    return _view != null;
  }

  void checkViewAttached() {
    if (_view == null) {
      throw new Exception("attached view is null!");
    }
  }

  T getView() {
    return _view;
  }
}
