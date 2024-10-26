class ChatUser {
  ChatUser({
     required this.email,
     required this.password,
     this.about,
     this.createdAt,
     this.id,
     this.image,
     this.isOnline,
     this.lastActive,
     this.name,
     this.pushToken,  
  });

  late  String email;
  late  String password;
  late  String? about;
  late  String? createdAt;
  late  String? id;
  late  String? image;
  late  bool? isOnline;
  late  String? lastActive;
  late  String? name;
  late  String? pushToken;
   

  ChatUser.fromJson(Map<String, dynamic> json) {
    about = json['about'] ?? ' ';
    createdAt = json['created_at'] ?? ' ';
    email = json['email'] ?? ' ';
    id = json['id'] ?? ' ';
    image = json['image'] ?? ' ';
    isOnline = json['is_online'] ?? false; // isOnline is a bool, so default to false
    lastActive = json['last_active'] ?? ' ';
    name = json['name'] ?? ' ';
    pushToken = json['push_token'] ?? ' ';
    password = json['password'] ?? ' '; 
  }

  Map<String, dynamic> toJson() {
    return {
      if (about != null) "about": about,
      if (createdAt != null) "created_at": createdAt,
           "email": email,
      if (isOnline != null) "is_online": isOnline,
      if (lastActive != null) "last_active": lastActive,
      if (name != null) "name": name,
      if (pushToken != null) "push_token": pushToken,
           "password": password,
    };
  }
}
