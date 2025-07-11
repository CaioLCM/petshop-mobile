import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/splash_page.dart';
import 'package:petshop_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:petshop_mobile/features/produtos/presentation/providers/produto_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProdutoProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashPage(),
      ),
    );
  }
}
