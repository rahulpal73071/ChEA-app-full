class Event {
  final String title;
  final String year;
  final String type; // 'photos', 'video', 'document', etc.
  final List<EventLink> links;

  Event({
    required this.title,
    required this.year,
    required this.type,
    required this.links,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      year: json['year'],
      type: json['type'],
      links: (json['links'] as List<dynamic>)
          .map((e) => EventLink.fromJson(e))
          .toList(),
    );
  }
}

class EventLink {
  final String type;
  final String url;

  EventLink({required this.type, required this.url});

  factory EventLink.fromJson(Map<String, dynamic> json) {
    return EventLink(
      type: json['type'],
      url: json['url'],
    );
  }
}
