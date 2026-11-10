import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/model_repository.dart';
import '../../domain/models/model_info.dart';
import '../../../settings/presentation/providers/settings_notifier.dart';

part 'model_notifier.g.dart';
part 'model_notifier.freezed.dart';

@freezed
class ModelState with _$ModelState {
  const factory ModelState({
    @Default([]) List<OllamaModel> installedModels,
    String? activeModel,
    @Default(false) bool isLoading,
    @Default(false) bool isConnected,
    String? serverVersion,
    String? errorMessage,
    @Default({}) Map<String, PullProgress> activePulls,
  }) = _ModelState;
}

@Riverpod(keepAlive: true)
ModelRepository modelRepository(Ref ref) {
  return ModelRepository();
}

@Riverpod(keepAlive: true)
class Model extends _$Model {
  ModelRepository get _repository => ref.read(modelRepositoryProvider);
  final Map<String, StreamSubscription<PullProgress>> _subscriptions = {};

  @override
  ModelState build() {
    ref.onDispose(() {
      for (final sub in _subscriptions.values) {
        sub.cancel();
      }
      _subscriptions.clear();
    });

    // Automatically trigger initial refresh
    Future.microtask(() => refreshModels());

    return const ModelState(isLoading: true);
  }

  String get _baseUrl => ref.read(settingsProvider).ollamaHost;

  Future<void> refreshModels() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final version = await _repository.checkServer(_baseUrl);
      if (version == null) {
        state = state.copyWith(
          isLoading: false,
          isConnected: false,
          serverVersion: null,
          errorMessage: 'Ollama is offline or unreachable at $_baseUrl',
        );
        return;
      }

      final models = await _repository.fetchInstalledModels(_baseUrl);
      
      // Determine active model: keep existing, or use default from settings, or first installed
      String? currentActive = state.activeModel;
      if (currentActive == null || !models.any((m) => m.name == currentActive)) {
        final defaultSetting = ref.read(settingsProvider).defaultModel;
        if (models.any((m) => m.name == defaultSetting)) {
          currentActive = defaultSetting;
        } else if (models.isNotEmpty) {
          currentActive = models.first.name;
        } else {
          currentActive = null;
        }
      }

      state = state.copyWith(
        installedModels: models,
        activeModel: currentActive,
        isLoading: false,
        isConnected: true,
        serverVersion: version,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isConnected: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectActiveModel(String modelName) {
    state = state.copyWith(activeModel: modelName);
    ref.read(settingsProvider.notifier).updateDefaultModel(modelName);
  }

  Future<void> pullModel(String modelName) async {
    final cleanName = modelName.trim();
    if (cleanName.isEmpty) return;

    if (_subscriptions.containsKey(cleanName)) {
      // Already pulling
      return;
    }

    final updatedPulls = Map<String, PullProgress>.from(state.activePulls);
    updatedPulls[cleanName] = PullProgress(
      modelName: cleanName,
      status: 'starting...',
      isDone: false,
    );
    state = state.copyWith(activePulls: updatedPulls);

    final stream = _repository.pullModelStream(
      baseUrl: _baseUrl,
      modelName: cleanName,
    );

    _subscriptions[cleanName] = stream.listen(
      (progress) {
        final currentPulls = Map<String, PullProgress>.from(state.activePulls);
        if (progress.isDone || progress.error != null) {
          currentPulls.remove(cleanName);
          _subscriptions[cleanName]?.cancel();
          _subscriptions.remove(cleanName);
          state = state.copyWith(
            activePulls: currentPulls,
            errorMessage: progress.error,
          );
          if (progress.isDone) {
            refreshModels();
          }
        } else {
          currentPulls[cleanName] = progress;
          state = state.copyWith(activePulls: currentPulls);
        }
      },
      onError: (err) {
        final currentPulls = Map<String, PullProgress>.from(state.activePulls);
        currentPulls.remove(cleanName);
        _subscriptions[cleanName]?.cancel();
        _subscriptions.remove(cleanName);
        state = state.copyWith(
          activePulls: currentPulls,
          errorMessage: 'Failed to pull $cleanName: $err',
        );
      },
      onDone: () {
        final currentPulls = Map<String, PullProgress>.from(state.activePulls);
        currentPulls.remove(cleanName);
        _subscriptions.remove(cleanName);
        state = state.copyWith(activePulls: currentPulls);
        refreshModels();
      },
    );
  }

  void cancelPull(String modelName) {
    _subscriptions[modelName]?.cancel();
    _subscriptions.remove(modelName);
    final updatedPulls = Map<String, PullProgress>.from(state.activePulls);
    updatedPulls.remove(modelName);
    state = state.copyWith(activePulls: updatedPulls);
  }

  Future<bool> deleteModel(String modelName) async {
    try {
      await _repository.deleteModel(
        baseUrl: _baseUrl,
        modelName: modelName,
      );
      await refreshModels();
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to delete $modelName: $e');
      return false;
    }
  }
}

typedef ModelManagementNotifier = Model;
