import 'package:bookclub_app/cubit/book_cubit.dart';
import 'bookdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Club'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                final cubit = BlocProvider.of<BookCubit>(context);
                if (value == 'title') {
                  cubit.filterByTitle();
                } else if (value == 'author') {
                  cubit.filterByAuthor();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'title', child: Text('Sort by Title')),
                const PopupMenuItem(value: 'author', child: Text('Sort by Author')),
              ],
            ),
          ],         
        ),
        body: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            if(state is BookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailPage(book: book),
                          ),
                      ).then((_) {
                        context.read<BookCubit>().init();
                      });
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('Error loading books'));
            }
          },
        ),
      ),
    );
  }
}