import 'package:core/src/riverpod/global_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LifeCycleWrapper extends ConsumerStatefulWidget {
  const LifeCycleWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  ConsumerState<LifeCycleWrapper> createState() => _LifeCycleWrapperState();
}

class _LifeCycleWrapperState extends ConsumerState<LifeCycleWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshApp();
    }
  }

  void refreshApp() {
    ref.read(globalProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
