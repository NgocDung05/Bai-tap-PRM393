class Trailer {
  final String title;
  Trailer({required this.title});
}

class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String overview;
  final double rating;
  final List<String> genres;
  final List<Trailer> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.rating,
    required this.genres,
    required this.trailers,
  });
}

// Dữ liệu mẫu (Đã thay bằng 2 phim hot)
final List<Movie> sampleMovies = [
  Movie(
    id: 'm1',
    title: 'Oppenheimer',
    // Ảnh minh họa mang phong cách vụ nổ/nguyên tử
    posterUrl: 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?auto=format&fit=crop&w=800&q=80',
    overview: 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II.',
    rating: 8.9,
    genres: ['Biography', 'Drama', 'History'],
    trailers: [
      Trailer(title: 'Official Trailer'),
      Trailer(title: 'Announcement Teaser')
    ],
  ),
  Movie(
    id: 'm2',
    title: 'Spider-Man: Across the Spider-Verse',
    // Ảnh minh họa mang phong cách người nhện / thành phố neon
    posterUrl: 'https://images.unsplash.com/photo-1604200213928-ba3cf4fc8436?auto=format&fit=crop&w=800&q=80',
    overview: 'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.',
    rating: 8.7,
    genres: ['Animation', 'Action', 'Adventure'],
    trailers: [
      Trailer(title: 'Official Trailer #1'),
      Trailer(title: 'Miles & Gwen Clip')
    ],
  ),
];