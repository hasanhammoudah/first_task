import 'package:ecommerce/presentation/product_cubit/products_cubit.dart';
import 'package:ecommerce/presentation/product_cubit/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          // استدعاء تحميل المنتجات في حالة البداية
          if (state is ProductInitial) {
            context.read<ProductCubit>().loadProducts();
            return const Center(child: Text('Loading products...'));
          }
          // حالة التحميل
          else if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // حالة تحميل البيانات بنجاح
          else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            );
          }
          // حالة وجود خطأ
          else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          // أي حالة غير معروفة
          return const Center(child: Text('Unknown state.'));
        },
      ),
    );
  }
}
