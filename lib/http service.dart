class httpInfo{
  String serverPath;
}

var pathControler = httpInfoController();

class httpInfoController{
  httpInfo path;
  save(String newPath){
    path.serverPath = newPath;
  }
  getPath(){
    return path;
  }
}