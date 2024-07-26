class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email});
}

class Message {
  final String id;
  final User sender;
  final String content;
  final DateTime timestamp;
  final String type; // 'text', 'image', or 'file'

  Message(
      {required this.id,
      required this.sender,
      required this.content,
      required this.timestamp,
      this.type = 'text'});
}

// Dummy data
final currentUser = User(
    id: '1', firstName: 'John', lastName: 'Doe', email: 'john@example.com');
final chatPartner = User(
    id: '2', firstName: 'Jane', lastName: 'Smith', email: 'jane@example.com');

final List<Message> dummyMessages = [
  Message(
      id: '1',
      sender: currentUser,
      content: 'Hello!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
  Message(
      id: '2',
      sender: chatPartner,
      content: 'Hi there!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 4))),
  Message(
      id: '3',
      sender: currentUser,
      content: 'How are you?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3))),
  Message(
      id: '4',
      sender: chatPartner,
      content: 'I\'m good, thanks! How about you?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
  Message(
      id: '5',
      sender: currentUser,
      content: 'I\'m doing well too. Just working on a Flutter app.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1))),
];
