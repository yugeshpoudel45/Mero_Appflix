import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/cubit/guest_session_cubit.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  bool generateSession = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  generateSession = true;
                });
              },
              child: const Text('Generate Guest Session'),
            ),
          ),
          generateSession ? const GenerateGuestSession() : const SizedBox(),
        ],
      ),
    );
  }
}

class GenerateGuestSession extends StatefulWidget {
  const GenerateGuestSession({super.key});

  @override
  State<GenerateGuestSession> createState() => _GenerateGuestSessionState();
}

class _GenerateGuestSessionState extends State<GenerateGuestSession> {
  @override
  void initState() {
    super.initState();
    context.read<GuestSessionCubit>().onGeneratingGuestSession();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestSessionCubit, GuestSessionState>(
      builder: (context, state) {
        if (state is GuestSessionLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GuestSessionLoadedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Session Generated Successfully'),
              Text(state.guestSessionModel.success.toString()),
              Text(state.guestSessionModel.guestSessionId.toString()),
              Text(state.guestSessionModel.expiresAt.toString()),
            ],
          );
        } else if (state is GuestSessionErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
