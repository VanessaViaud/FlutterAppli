//faire une classe avec 2 attributs privés title et desc donc faire des getters et setter

class Project {
  String _title;
  String _desc;

  Project(this._title, this._desc);

  String get title => _title;
  String get desc => _desc;

  set title(String value) => _title = value;
  set desc(String value) => _desc = value;
}




//il faut utiliser ListView pour affihcer la liste des projets. Attention il faut un contructeur spécifique et pas
//n'importe quel listview : celle qui va lister des listtile
//ou utiliser listview avec des card (on peut les mettre dans les listvew)
//attention : comme on fait ça avec des objets, la liste doit être dynamique donc faut la faire avec un builder : listview.builder