class RoomCategory {
  String name;
  String id;
  String imageName;
  RoomCategory({required this.id, required this.name, required this.imageName});
  static List<RoomCategory> getRoomCategories() {
    return [
      RoomCategory(id: 'music', name: 'Music', imageName: 'music.png'),
      RoomCategory(id: 'movie', name: 'Movies', imageName: 'movie.png'),
      RoomCategory(id: 'sport', name: 'Sports', imageName: 'sport.png'),
    ];
  }


}
