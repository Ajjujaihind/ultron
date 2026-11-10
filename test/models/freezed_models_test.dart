import 'package:flutter_test/flutter_test.dart';
import 'package:ultron/features/chat/domain/models/chat_message.dart';
import 'package:ultron/features/chat/domain/models/conversation.dart';
import 'package:ultron/features/models/domain/models/model_info.dart';
import 'package:ultron/features/settings/domain/models/app_settings.dart';

void main() {
  group('Freezed Domain Models Test', () {
    test('OllamaModel serialization & deserialization', () {
      final json = {
        'name': 'llama3.2:latest',
        'model': 'llama3.2:latest',
        'size': 2019393189,
        'digest': 'a80c4f17fad5',
        'details': {
          'format': 'gguf',
          'family': 'llama',
          'parameter_size': '3.2B',
          'quantization_level': 'Q4_K_M',
        },
      };

      final model = OllamaModel.fromJson(json);
      expect(model.name, 'llama3.2:latest');
      expect(model.size, 2019393189);
      expect(model.details?.parameterSize, '3.2B');
      expect(model.details?.quantizationLevel, 'Q4_K_M');

      final serialized = model.toJson();
      expect(serialized['name'], 'llama3.2:latest');
      expect(model.details?.parameterSize, '3.2B');
      expect(model.details?.toJson()['parameter_size'], '3.2B');
    });

    test('PullProgress status and calculations', () {
      const progress = PullProgress(
        modelName: 'mistral:7b',
        status: 'downloading',
        completed: 500000,
        total: 1000000,
      );

      expect(progress.modelName, 'mistral:7b');
      expect(progress.isDone, false);
      expect(progress.completed, 500000);
      expect(progress.total, 1000000);
    });

    test('ChatMessage & Conversation serialization', () {
      final now = DateTime.now();
      final msg = ChatMessage(
        id: 'msg-1',
        role: 'user',
        content: 'Hello Ultron!',
        createdAt: now,
      );

      expect(msg.role, 'user');
      expect(msg.content, 'Hello Ultron!');

      final conv = Conversation(
        id: 'conv-1',
        title: 'Greeting Chat',
        model: 'llama3.2',
        createdAt: now,
        updatedAt: now,
        messages: [msg],
      );

      expect(conv.messages.length, 1);
      final json = conv.toJson();
      json['messages'] = conv.messages.map((m) => m.toJson()).toList();
      final revived = Conversation.fromJson(json);
      expect(revived.id, 'conv-1');
      expect(revived.messages.first.content, 'Hello Ultron!');
    });

    test('AppSettings defaults & updates', () {
      const settings = AppSettings();
      expect(settings.ollamaHost, 'http://127.0.0.1:11434');
      expect(settings.defaultModel, 'llama3.2');
      expect(settings.temperature, 0.7);

      final updated = settings.copyWith(temperature: 0.2);
      expect(updated.temperature, 0.2);
      expect(updated.ollamaHost, 'http://127.0.0.1:11434');
    });
  });
}
