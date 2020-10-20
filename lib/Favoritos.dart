/// todo: local storage for fav.
var favoritosController = FavoritosController();

class FavoritosController {
  var _favList = [];

  getall() {
    return _favList;
  }

  isFaved(id) {
    for (var ids in _favList) {
      if (ids == id) {
        return true;
      }
    }
    return false;
  }

  update(id) {
    bool inList = isFaved(id);
    if (inList) {
      print('removido');
      remove(id);
    }
    else {
      print(_favList);
      return _favList.add(id);
    }
  }

  remove(id) {
    var idx = _favList.indexWhere((element) => element == id);
    print(_favList);
    _favList.removeAt(idx);
    print(_favList);
  }
}