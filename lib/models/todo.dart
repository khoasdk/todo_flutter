class Todo {
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Todo(this._title, this._date, [this._description]);
  Todo.withId(this._id, this._title, this._date, [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String value) {
    if (value.length <= 255) this._title = value;
  }
  set description(String value) {
    if (value.length <= 255) this._description = value;
  }
  set date(String value) {
    this._date = value;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['desciption'];
    _priority = map['priority'];
    _date = map['date'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }
}