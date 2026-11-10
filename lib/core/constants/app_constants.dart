abstract final class AppConstants {
  static const String appName = 'Ultron';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Offline AI Chat';
  static const String defaultOllamaHost = 'http://127.0.0.1:11434';
  static const String defaultModel = 'llama3.2';
  static const String defaultSystemPrompt =
      'You are a helpful assistant. Be concise and clear in your responses.';
  static const double defaultTemperature = 0.7;

  // Ollama API Endpoints
  static const String tagsEndpoint = '/api/tags';
  static const String pullEndpoint = '/api/pull';
  static const String deleteEndpoint = '/api/delete';
  static const String chatEndpoint = '/api/chat';
  static const String versionEndpoint = '/api/version';
  static const String showEndpoint = '/api/show';

  // Local storage keys/files
  static const String conversationsFileName = 'conversations.json';
  static const String settingsFileName = 'settings.json';
}

class RecommendedModelPreset {
  final String tag;
  final String displayName;
  final String description;
  final String parameterSize;
  final String approxDownloadSize;

  const RecommendedModelPreset({
    required this.tag,
    required this.displayName,
    required this.description,
    required this.parameterSize,
    required this.approxDownloadSize,
  });
}

const List<RecommendedModelPreset> recommendedModels = [
  // ─────────────────────────────────────────────
  // < 1 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'qwen2.5:0.5b',
    displayName: 'Qwen 2.5 (0.5B)',
    description:
        'Extremely lightweight model for basic tasks and low-resource devices.',
    parameterSize: '0.5B',
    approxDownloadSize: '400 MB',
  ),

  // ─────────────────────────────────────────────
  // 1 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'qwen2.5:1.5b',
    displayName: 'Qwen 2.5 (1.5B)',
    description: 'Small multilingual model optimized for fast responses.',
    parameterSize: '1.5B',
    approxDownloadSize: '1.0 GB',
  ),
  RecommendedModelPreset(
    tag: 'qwen2.5-coder:1.5b',
    displayName: 'Qwen 2.5 Coder (1.5B)',
    description:
        'Lightweight coding model for code generation and programming assistance.',
    parameterSize: '1.5B',
    approxDownloadSize: '1.0 GB',
  ),

  // ─────────────────────────────────────────────
  // 1.1 - 1.3 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'deepseek-r1:1.5b',
    displayName: 'DeepSeek-R1 (1.5B)',
    description: 'Compact reasoning model distilled from DeepSeek-R1.',
    parameterSize: '1.5B',
    approxDownloadSize: '1.1 GB',
  ),
  RecommendedModelPreset(
    tag: 'llama3.2:1b',
    displayName: 'Llama 3.2 (1B)',
    description:
        'Ultra-fast and lightweight model. Ideal for quick queries and low RAM usage.',
    parameterSize: '1.2B',
    approxDownloadSize: '1.3 GB',
  ),

  // ─────────────────────────────────────────────
  // 1.6 - 1.9 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'gemma2:2b',
    displayName: 'Gemma 2 (2B)',
    description: 'Lightweight Google model designed for fast local inference.',
    parameterSize: '2B',
    approxDownloadSize: '1.6 GB',
  ),
  RecommendedModelPreset(
    tag: 'starcoder2:3b',
    displayName: 'StarCoder2 (3B)',
    description:
        'Compact programming model trained for code generation and completion.',
    parameterSize: '3B',
    approxDownloadSize: '1.7 GB',
  ),
  RecommendedModelPreset(
    tag: 'qwen2.5:3b',
    displayName: 'Qwen 2.5 (3B)',
    description:
        'Strong multilingual model with excellent coding and technical capabilities.',
    parameterSize: '3B',
    approxDownloadSize: '1.9 GB',
  ),

  // ─────────────────────────────────────────────
  // 2.0 - 2.2 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'llama3.2:3b',
    displayName: 'Llama 3.2 (3B)',
    description:
        'Compact Meta model offering a strong balance between speed and intelligence.',
    parameterSize: '3B',
    approxDownloadSize: '2.0 GB',
  ),
  RecommendedModelPreset(
    tag: 'phi3:mini',
    displayName: 'Phi-3 Mini (3.8B)',
    description:
        'Microsoft lightweight model optimized for mathematics, logic, and reasoning.',
    parameterSize: '3.8B',
    approxDownloadSize: '2.2 GB',
  ),

  // ─────────────────────────────────────────────
  // 3.5 - 4.0 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'yi:6b',
    displayName: 'Yi (6B)',
    description:
        'Efficient general-purpose model with strong language understanding.',
    parameterSize: '6B',
    approxDownloadSize: '3.5 GB',
  ),
  RecommendedModelPreset(
    tag: 'codellama:7b',
    displayName: 'Code Llama (7B)',
    description:
        'Meta coding model designed for programming and code generation.',
    parameterSize: '7B',
    approxDownloadSize: '3.8 GB',
  ),
  RecommendedModelPreset(
    tag: 'starcoder2:7b',
    displayName: 'StarCoder2 (7B)',
    description:
        'Powerful open coding model for programming and code generation.',
    parameterSize: '7B',
    approxDownloadSize: '4.0 GB',
  ),

  // ─────────────────────────────────────────────
  // 4.1 - 4.7 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'mistral:7b',
    displayName: 'Mistral (7B)',
    description:
        'Fast and capable general-purpose model with strong reasoning abilities.',
    parameterSize: '7B',
    approxDownloadSize: '4.1 GB',
  ),
  RecommendedModelPreset(
    tag: 'llama3.1:8b',
    displayName: 'Llama 3.1 (8B)',
    description:
        'Powerful general-purpose model with strong reasoning and instruction following.',
    parameterSize: '8B',
    approxDownloadSize: '4.7 GB',
  ),
  RecommendedModelPreset(
    tag: 'qwen2.5:7b',
    displayName: 'Qwen 2.5 (7B)',
    description:
        'Highly capable multilingual general-purpose model with strong reasoning.',
    parameterSize: '7B',
    approxDownloadSize: '4.7 GB',
  ),
  RecommendedModelPreset(
    tag: 'deepseek-r1:7b',
    displayName: 'DeepSeek-R1 (7B)',
    description:
        'Strong reasoning model suitable for mathematics, coding, and analytical tasks.',
    parameterSize: '7B',
    approxDownloadSize: '4.7 GB',
  ),
  RecommendedModelPreset(
    tag: 'qwen2.5-coder:7b',
    displayName: 'Qwen 2.5 Coder (7B)',
    description:
        'Strong coding model for software development, debugging, and code generation.',
    parameterSize: '7B',
    approxDownloadSize: '4.7 GB',
  ),
  RecommendedModelPreset(
    tag: 'llava:7b',
    displayName: 'LLaVA (7B)',
    description:
        'Vision-language model capable of analyzing images and answering questions about them.',
    parameterSize: '7B',
    approxDownloadSize: '4.7 GB',
  ),

  // ─────────────────────────────────────────────
  // 5.4 - 7.9 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'gemma2:9b',
    displayName: 'Gemma 2 (9B)',
    description:
        'High-quality compact model with strong reasoning and instruction following.',
    parameterSize: '9B',
    approxDownloadSize: '5.4 GB',
  ),
  RecommendedModelPreset(
    tag: 'mistral-nemo:12b',
    displayName: 'Mistral Nemo (12B)',
    description:
        'Powerful 12B model with excellent instruction following and multilingual support.',
    parameterSize: '12B',
    approxDownloadSize: '7.1 GB',
  ),
  RecommendedModelPreset(
    tag: 'codellama:13b',
    displayName: 'Code Llama (13B)',
    description:
        'Larger Code Llama model for advanced software development tasks.',
    parameterSize: '13B',
    approxDownloadSize: '7.4 GB',
  ),
  RecommendedModelPreset(
    tag: 'llama3.2-vision:11b',
    displayName: 'Llama 3.2 Vision (11B)',
    description: 'Multimodal model capable of understanding images and text.',
    parameterSize: '11B',
    approxDownloadSize: '7.9 GB',
  ),
  RecommendedModelPreset(
    tag: 'phi3:medium',
    displayName: 'Phi-3 Medium (14B)',
    description:
        'More capable Phi model for reasoning, coding, and complex instructions.',
    parameterSize: '14B',
    approxDownloadSize: '7.9 GB',
  ),

  // ─────────────────────────────────────────────
  // 9.0 - 9.1 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'qwen2.5:14b',
    displayName: 'Qwen 2.5 (14B)',
    description:
        'Advanced multilingual model for complex reasoning, coding, and analysis.',
    parameterSize: '14B',
    approxDownloadSize: '9.0 GB',
  ),
  RecommendedModelPreset(
    tag: 'deepseek-r1:14b',
    displayName: 'DeepSeek-R1 (14B)',
    description:
        'Advanced reasoning model for complex analysis, mathematics, and coding.',
    parameterSize: '14B',
    approxDownloadSize: '9 GB',
  ),
  RecommendedModelPreset(
    tag: 'qwen2.5-coder:14b',
    displayName: 'Qwen 2.5 Coder (14B)',
    description:
        'Advanced coding model for complex programming and software engineering tasks.',
    parameterSize: '14B',
    approxDownloadSize: '9 GB',
  ),
  RecommendedModelPreset(
    tag: 'phi4',
    displayName: 'Phi-4',
    description:
        'Microsoft reasoning model with strong performance on mathematics and technical tasks.',
    parameterSize: '14B',
    approxDownloadSize: '9.1 GB',
  ),

  // ─────────────────────────────────────────────
  // 16 - 20 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'gemma2:27b',
    displayName: 'Gemma 2 (27B)',
    description:
        'Large Google model for advanced reasoning and complex generation tasks.',
    parameterSize: '27B',
    approxDownloadSize: '16 GB',
  ),
  RecommendedModelPreset(
    tag: 'qwen2.5:32b',
    displayName: 'Qwen 2.5 (32B)',
    description:
        'Large high-performance model for demanding reasoning and coding workloads.',
    parameterSize: '32B',
    approxDownloadSize: '20 GB',
  ),
  RecommendedModelPreset(
    tag: 'deepseek-r1:32b',
    displayName: 'DeepSeek-R1 (32B)',
    description:
        'Large reasoning model designed for demanding analytical and coding workloads.',
    parameterSize: '32B',
    approxDownloadSize: '20 GB',
  ),
  RecommendedModelPreset(
    tag: 'command-r:35b',
    displayName: 'Command R (35B)',
    description:
        'Enterprise-focused model with strong instruction following and retrieval capabilities.',
    parameterSize: '35B',
    approxDownloadSize: '20 GB',
  ),

  // ─────────────────────────────────────────────
  // 26 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'mixtral:8x7b',
    displayName: 'Mixtral (8x7B)',
    description:
        'Mixture-of-experts model designed for high-quality reasoning and generation.',
    parameterSize: '46.7B',
    approxDownloadSize: '26 GB',
  ),

  // ─────────────────────────────────────────────
  // 40 GB
  // ─────────────────────────────────────────────
  RecommendedModelPreset(
    tag: 'llama3.1:70b',
    displayName: 'Llama 3.1 (70B)',
    description:
        'Large high-capability model for advanced reasoning and complex tasks.',
    parameterSize: '70B',
    approxDownloadSize: '40 GB',
  ),
];
