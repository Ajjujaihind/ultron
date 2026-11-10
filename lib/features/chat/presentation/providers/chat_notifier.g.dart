// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRepositoryHash() => r'f4671781f2878a3bdee593e145b6af6c24b86608';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = Provider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = ProviderRef<ChatRepository>;
String _$conversationListHash() => r'731471d3f79dadd085e6cf15a08643cc1d3a5564';

/// See also [ConversationList].
@ProviderFor(ConversationList)
final conversationListProvider =
    NotifierProvider<ConversationList, List<Conversation>>.internal(
      ConversationList.new,
      name: r'conversationListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ConversationList = Notifier<List<Conversation>>;
String _$chatHash() => r'6d1dd89bde8c2d83b25775b74e8c90937b03a66a';

/// See also [Chat].
@ProviderFor(Chat)
final chatProvider = NotifierProvider<Chat, ChatState>.internal(
  Chat.new,
  name: r'chatProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Chat = Notifier<ChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
