class Book {
  String? author;
  String? bookTitle;
  String? category;
  String? imageUrl;
  Map<String, dynamic>? chapters;
  bool? isBookmarked;

  Book();

  Map<String, dynamic> toJson() => {
        'Author': author,
        'Book_Title': bookTitle,
        'Category': category,
        'imageUrl': imageUrl,
        'Chapters': [],
        'isBookmarked': isBookmarked,
      };

  Book.fromSnapshot(snapshot)
      : author = snapshot.data()['Author'],
        bookTitle = snapshot.data()['Book_Title'],
        category = snapshot.data()['Category'],
        imageUrl = snapshot.data()['imageUrl'],
        chapters = snapshot.data()['Chapters'],
        isBookmarked = snapshot.data()['isBookmarked'];
}
