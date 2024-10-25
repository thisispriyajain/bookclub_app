import 'package:bookclub_app/cubit/book_cubit.dart';
import 'bookdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Club'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Books',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

           SizedBox(
            height: 250.0,
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  if(state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  book.imageURL,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 150,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(book.author),
                              ],
                            ),
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
      );
    }
  }