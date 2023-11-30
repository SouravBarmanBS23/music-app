import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_auth_notifier.dart';

final dropBoxAuthProvider = NotifierProvider<DropBoxAuthNotifier, AuthState>(
  DropBoxAuthNotifier.new,
);
