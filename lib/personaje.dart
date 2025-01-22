class Character {
  final String url;
  final String name;
  final String gender;
  final String culture;
  final String born;


  const Character({required this.url, required this.name, required this.gender, 
                    required this.culture, required this.born});
  
  factory Character.fromJson(Map<String, dynamic> json){
    return Character(url: json['url'], name: json['name'] as String, gender: json['gender'] as String, 
                      culture: json['culture'] as String, born: json['born'] as String);
  }
}