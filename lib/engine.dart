import 'dart:async';

import 'package:flutter/material.dart' as md;
import 'package:flutter_local_ai/flutter_local_ai.dart';


class aiEngine with md.ChangeNotifier {
  final gemini = FlutterLocalAi();
  final prompt = md.TextEditingController();
  bool promptChanged = false;
  final instructions = md.TextEditingController();
  late AiResponse response;
  String responseText = "";
  bool isLoading = false;
  bool isAvailable = false;
  bool isInitialized = false;
  bool isInitializing = false;
  String status = "Loading Engine";
  bool isError = false;

  int tokens = 200;
  double temperature = 0.7; // Controls randomness (0.0 = deterministic, 1.0 = very random)


  void start(){
    check();
  }
  Future<void> check() async {
    try {
      await gemini.isAvailable().then((availability){
        isAvailable = availability;
        notifyListeners();
      });
    } catch (e) {
      isAvailable = false;
      analyzeError("Checking availability", e);
    }
  }

  Future<void> initialize() async {
    if (isInitializing) return;
    isInitializing = true;
    notifyListeners();
    try {
      await gemini.initialize(
        instructions: instructions.text.isEmpty
            ? null
            : instructions.text,
      ).then((result){
        isInitialized = result;
        isInitializing = false;
        notifyListeners();
      });

      if (isInitialized) {
        status = "Gemini Nano initialized successfully";
        notifyListeners();
      } else {
        status = "Gemini Nano failed to initialize";
        notifyListeners();
      }
    } catch (e) {
      isInitialized = false;
      isInitializing = false;
      notifyListeners();
      analyzeError("Initialization", e);
    }
  }

  void checkAICore(){
    gemini.openAICorePlayStore();
  }

  void analyzeError(String action, e){
    isError = true;
    responseText = e.toString();
    notifyListeners();
  }
  Future<void> generate() async {
    isError = false;
    if (prompt.text.isEmpty) {
      status = "Please enter your prompt";
      notifyListeners();
      return;
    }

    if (!isInitializing) {
      await initialize();
    }
    isLoading = true;
    notifyListeners();
    try {
      await gemini.generateText(
        prompt: prompt.text,
        config: GenerationConfig(
            maxTokens: tokens,
            temperature: temperature
        ),
      ).then((output){
        response = output;
        responseText = response.text;
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      responseText = "Something went wrong";
      isLoading = false;
      notifyListeners();

      analyzeError("Generation", e);
    }
  }
}