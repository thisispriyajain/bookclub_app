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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BookCubit>(context).filterByAuthor();
                    },
                    child: const Text('Author'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BookCubit>(context).filterByTitle();
                    },
                    child: const Text('Title'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  if(state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return GestureDetector(
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
                            child: Column(
                              children: [
                                Image.network(book.imageURL),
                                Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(book.author),
                              ],
                            ),
                          );
                        },
                      );
                  } else {
                    return const Center(child: Text('Error loading books'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}