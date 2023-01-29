class Word {
  int? id;
  final String topic;
  final String theword;
  final String type;
  final String sentence;

  Word({
    required this.topic,
    required this.theword,
    required this.type,
    required this.sentence,
  });

  Map<String, dynamic> toMap() {
    return {'topic': topic, 'theword': theword, 'type': type};
  }

  factory Word.fromMap({required Map<String, dynamic> map}) {
    return Word(
        topic: map['topic'],
        theword: map['theword'],
        type: map['type'],
        sentence: '');
  }
}
