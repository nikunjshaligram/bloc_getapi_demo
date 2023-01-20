import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api_bloc/blocs/app_blocs.dart';
import 'package:get_api_bloc/blocs/app_events.dart';
import 'package:get_api_bloc/blocs/app_states.dart';
import 'package:get_api_bloc/models/user_model.dart';
import 'package:get_api_bloc/repos/repositories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(
          LoadUserEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Get API With BLoC"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;

              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        // final snackbar = SnackBar(
                        //   content: Text("$userList[index]}"),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      child: Card(
                        color: Colors.blueGrey,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                userList[index].firstName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                userList[index].lastName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            userList[index].email,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(
                              userList[index].avatar,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is UserErrorState) {
              return const Center(
                child: Text("error"),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
