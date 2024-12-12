import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/data/services/api_service.dart';
import 'package:ecommerce/presentation/product_cubit/products_cubit.dart';
import 'package:ecommerce/presentation/views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ProductCubit(ProductRepository(ApiService())),
        child: const ProductScreen(),
      ),
    );
  }
}
