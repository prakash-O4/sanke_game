//this file is for bloc and in future this game will be made by using flutter bloc pattern 

// import 'dart:math';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/snake_bloc.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider(
//         create: (context) => SnakeBloc(),
//         child: MyHomePage(title: 'Flutter Demo Home Page'),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static List<int> snakePosition = [45, 65, 85, 105, 125];
//   int numberOfBlocks = 760;
//   static var random = Random();
//   int food = random.nextInt(700);
//   void generateFood() {
//     food = random.nextInt(700);
//   }

//   void startgame() {
//     snakePosition = [45, 65, 85, 105, 125];
//     const duration = Duration(milliseconds: 300);
//     Timer.periodic(duration, (Timer _timer) {
//       updateSnake();
//       if (gameOver()) {
//         _timer.cancel();
//         gameOverScreen();
//       }
//     });
//   }

//   bool gameOver() {
//     for (int i = 0; i < snakePosition.length; i++) {
//       int count = 0;
//       for (int j = 0; j < snakePosition.length; j++) {
//         if (snakePosition[i] == snakePosition[j]) {
//           count += 1;
//         }
//         if (count == 2) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }

//   void pauseGame() {}

//   void gameOverScreen() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Game Over'),
//             content: Text('Your Score is' + snakePosition.length.toString()),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   startgame();
//                   Navigator.pop(context);
//                 },
//                 child: Text('Start Again'),
//               ),
//             ],
//           );
//         });
//   }

//   var direction = 'down';
//   void updateSnake() {
//     switch (direction) {
//       case 'down':
//         if (snakePosition.last > 740) {
//           snakePosition.add(snakePosition.last + 20 - 760);
//         } else {
//           snakePosition.add(snakePosition.last + 20);
//         }
//         break;
//       case 'up':
//         if (snakePosition.last < 20) {
//           snakePosition.add(snakePosition.last - 20 + 760);
//         } else {
//           snakePosition.add(snakePosition.last - 20);
//         }
//         break;
//       case 'left':
//         if (snakePosition.last % 20 == 0) {
//           snakePosition.add(snakePosition.last - 1 + 20);
//         } else {
//           snakePosition.add(snakePosition.last - 1);
//         }
//         break;
//       case 'right':
//         if ((snakePosition.last + 1) % 20 == 0) {
//           snakePosition.add(snakePosition.last + 1 - 20);
//         } else {
//           snakePosition.add(snakePosition.last + 1);
//         }
//         break;
//     }
//     if (snakePosition.last == food) {
//       generateFood();
//     } else {
//       snakePosition.removeAt(0);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             BlocBuilder<SnakeBloc, SnakeState>(
//               builder: (context, state) {
//                 if (state is SnakeState) {
//                   direction = state.direction;
//                   return Expanded(
//                     child: GestureDetector(
//                       onVerticalDragUpdate: (details) {
//                         if (direction != 'up' && details.delta.dy > 0) {
//                           // direction = 'down';
//                           BlocProvider.of<SnakeBloc>(context)
//                               .add(SnakeDirection(snakeDirection: 'down'));
//                         } else if (direction != 'down' &&
//                             details.delta.dy < 0) {
//                           // direction = 'up';
//                           BlocProvider.of<SnakeBloc>(context)
//                               .add(SnakeDirection(snakeDirection: 'up'));
//                         }
//                       },
//                       onHorizontalDragUpdate: (details) {
//                         if (direction != 'left' && details.delta.dx > 0) {
//                           // direction = 'right';
//                           BlocProvider.of<SnakeBloc>(context)
//                               .add(SnakeDirection(snakeDirection: 'right'));
//                         } else if (direction != 'right' &&
//                             details.delta.dx < 0) {
//                           // direction = 'left';
//                           BlocProvider.of<SnakeBloc>(context)
//                               .add(SnakeDirection(snakeDirection: 'left'));
//                         }
//                       },
//                       child: Container(
//                         child: GridView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: numberOfBlocks,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 20,
//                           ),
//                           itemBuilder: (context, index) {
//                             if (snakePosition.contains(index)) {
//                               return _smallBox(Colors.white);
//                             }
//                             if (index == food) {
//                               return _smallBox(Colors.green);
//                             }
//                             return _smallBox(Colors.grey[900]);
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//                 return Text('error');
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       startgame();
//                       BlocProvider.of<SnakeBloc>(context)
//                           .add(SnakeDirection(snakeDirection: direction));
//                     },
//                     child: _bottomText('S T A R T'),
//                   ),
//                   _bottomText('@ R J B'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _bottomText(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 20,
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget _smallBox(Color? colors) {
//     return Container(
//       padding: EdgeInsets.all(2),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(5),
//         child: Container(
//           color: colors,
//         ),
//       ),
//     );
//   }
// }
