
class todos{
   final int userId;
   final int id ;
   final String title ;
   final bool completed ;
  
 const todos ({
  
  required this.userId, 
 required this.id,
 required  this.title,
 required this.completed, 

});

factory todos.fromJson(Map<String , dynamic> json){
  return todos(userId: json['userId'], id: json['id'], title: json['title'],completed: json['completed']);
}
}