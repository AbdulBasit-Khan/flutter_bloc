import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/switch_example/switch_bloc.dart';
import 'package:flutter_blo/bloc/switch_example/switch_event.dart';
import 'package:flutter_blo/bloc/switch_example/switch_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example Two"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notifications"),
                BlocBuilder<SwitchBloc, SwitchStates>(
                    buildWhen: (previous, current) =>
                        previous.isSwitch != current.isSwitch,
                    builder: (context, state) {
                      return Switch(
                          value: state.isSwitch,
                          onChanged: (newVal) {
                            context
                                .read<SwitchBloc>()
                                .add(EnableOrDisableNotification());
                          });
                    })
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<SwitchBloc, SwitchStates>(
              buildWhen: (previous, current) =>
                  previous.slider != current.slider,
              builder: (context, state) {
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<SwitchBloc, SwitchStates>(
              builder: (context, state) {
                return Slider(
                    value: state.slider,
                    onChanged: (value) {
                      context
                          .read<SwitchBloc>()
                          .add(SliderEvent(slider: value));
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
