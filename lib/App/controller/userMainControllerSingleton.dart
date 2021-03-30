class UserMainControllerSingleton {
  static final UserMainControllerSingleton _singleton =
      UserMainControllerSingleton._initializerFunction();

  int _screenIndex;
  int get screenIndex => _screenIndex;
  void setScreenIndex(value) {
    _screenIndex = value;
  }

  factory UserMainControllerSingleton() {
    return _singleton;
  }

  UserMainControllerSingleton._initializerFunction() {
    print('init');
  }
}
