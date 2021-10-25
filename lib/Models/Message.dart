import 'user_model.dart';

class Message {
  final User sender;
  final String time;
  final bool unread;
  final String message;

  Message({required this.sender,
    required this.time,
    required this.unread,
  required this.message}
      );

}

final User currentUser = User(
  id: 0,
  name: 'Current User',
  ppic: 'lib/UI/client_UI/images/1632866532451.jpeg',
  );

final User user1 = User(
    id: 1,
    name: 'Manuel',
    ppic: 'lib/UI/client_UI/images/imagen3.jpeg'
);

final User user2 = User(
    id: 2,
    name: 'Café Aguila Roja',
    ppic: 'lib/UI/client_UI/images/f90b1fd37c6f66c2842d853f9aa0e073.jpg'
);

final User user3 = User(
    id: 3,
    name: 'Yeison',
    ppic: 'lib/UI/client_UI/images/1632866532451.jpeg'
);

final User user4 = User(
    id: 4,
    name: 'Manuel',
    ppic: 'lib/UI/client_UI/images/imagen3.jpeg'
);

final User user5 = User(
    id: 5,
    name: 'Café Aguila Roja',
    ppic: 'lib/UI/client_UI/images/f90b1fd37c6f66c2842d853f9aa0e073.jpg'
);

final User user6 = User(
    id: 6,
    name: 'Yeison',
    ppic: 'lib/UI/client_UI/images/1632866532451.jpeg'
);

final User user7 = User(
    id: 7,
    name: 'Manuel',
    ppic: 'lib/UI/client_UI/images/imagen3.jpeg'
);

final User user8 = User(
    id: 8,
    name: 'Café Aguila Roja',
    ppic: 'lib/UI/client_UI/images/f90b1fd37c6f66c2842d853f9aa0e073.jpg'
);

final User user9 = User(
    id: 9,
    name: 'Yeison',
    ppic: 'lib/UI/client_UI/images/1632866532451.jpeg'
);

List<Message> clientChats = [

  Message(sender: user1,
      time: '12:20 PM',
      unread: true,
      message: 'Como asi? Hasta ahora veo esto amigo'
  ),


  Message(sender: user2,
      time: '1:45 PM',
      unread: false,
      message: 'Café Águila Roja, tomémonos un tinto... seamos amigos!'),

  Message(sender: user3,
      time: '7:48 AM',
      unread: false,
      message: 'Yuca'),

  Message(sender: user4,
      time: '12:20 PM',
      unread: true,
      message: 'Como asi? Hasta ahora veo esto amigo'
  ),

  Message(sender: user5,
      time: '1:45 PM',
      unread: false,
      message: 'Café Águila Roja, tomémonos un tinto... seamos amigos!'),

  Message(sender: user6,
      time: '7:48 AM',
      unread: false,
      message: 'Yuca'),

  Message(sender: user7,
      time: '12:20 PM',
      unread: true,
      message: 'Como asi? Hasta ahora veo esto amigo'
  ),

  Message(sender: user8,
      time: '1:45 PM',
      unread: false,
      message: 'Café Águila Roja, tomémonos un tinto... seamos amigos!'),

  Message(sender: user9,
      time: '7:48 AM',
      unread: false,
      message: 'Yuca'),




];

List<Message> clientMessages = [

  Message(sender: user1,
      time: '12:20 PM',
      unread: true,
      message: 'Como asi? Hasta ahora veo esto amigo'
  ),

  Message(sender: currentUser,
      time: '12:34 PM',
      unread: true,
      message: 'Si, al parecer no se dio cuenta de la request'
  ),

  Message(sender: user1,
      time: '1:45 PM',
      unread: false,
      message: 'Listo amigo no se preocupe, ya le soluciono'),

  Message(sender: user1,
      time: '1:46 PM',
      unread: false,
      message: 'Deme un momento y verifico la información'),

  Message(sender: currentUser,
      time: '1:47 PM',
      unread: true,
      message: 'vale, gracias'
  ),


];