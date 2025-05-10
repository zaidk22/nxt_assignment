import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nxt_assignment/injection_container.dart' as di;

import 'feature/article/presentation/bloc/article_bloc.dart';
import 'feature/article/presentation/view/articles_screen.dart';
import 'injection_container.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
       BlocProvider(
          create: (context) => sl<ArticleBloc>()..add(FetchArticles()),
        
      child: MaterialApp(
        title: 'Articles App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ArticlesScreen(),
      ),
    );
  }
}
