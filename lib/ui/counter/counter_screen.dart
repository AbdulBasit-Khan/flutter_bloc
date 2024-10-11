import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/counter_bloc/bloc/counter_bloc.dart';
import 'package:flutter_blo/bloc/counter_bloc/bloc/counter_event.dart';
import 'package:flutter_blo/bloc/counter_bloc/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;
  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }
@override
  void dispose() {
    // TODO: implement dispose
    _counterBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _counterBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter Example'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (previous, current) =>
                      previous.counter != current.counter,
                  builder: (context, state) {
                    return Center(
                        child: Text(
                      state.counter.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 60),
                    ));
                  }),
              // BlocBuilder<CounterBloc , CounterState>(
              //     buildWhen: (previous, current) => previous.isSwitchOn != current.isSwitchOn,
              //     builder: (context, state){
              //       return Center(child: Text(state.isSwitchOn.toString() ,
              //         style: const TextStyle(color: Colors.black , fontSize: 60),));
              //     }
              // ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<CounterBloc, CounterState>(
                      buildWhen: (previous, current) => false,
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CounterBloc>()
                                  .add(IncrementCounter());
                            },
                            child: const Text('Add'));
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<CounterBloc, CounterState>(
                      buildWhen: (previous, current) => false,
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CounterBloc>()
                                  .add(DecrementCounter());
                            },
                            child: const Text('Removed'));
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
