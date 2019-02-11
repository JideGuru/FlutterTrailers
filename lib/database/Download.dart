class Download{

  int _id;
  String _name;
  String _path;


  Download(this._id, this._name, this._path);

  Download.map(dynamic obj){
    this._id = obj['id'];
    this._name = obj['name'];
    this._path = obj['path'];
  }

  int get id => _id;
  String get name => _name;
  String get path => _path;



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['path'] = _path;

    return map;
  }

  Download.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._path = map['path'];
  }

}