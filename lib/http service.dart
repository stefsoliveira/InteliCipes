class httpInfo{
  String serverPath;
  httpInfo({this.serverPath});
}

var pathControler = httpInfoController();

class httpInfoController{
  httpInfo path = httpInfo();
  save(String newPath){
    path = httpInfo(
      serverPath: newPath
    );
  }
  getPath(){
    return path.serverPath;
  }
}