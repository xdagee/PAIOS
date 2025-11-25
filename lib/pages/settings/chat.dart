import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../engine.dart';
import '../support/elements.dart';


class ChatSettingsPage extends StatefulWidget {
  const ChatSettingsPage({super.key});
  @override
  ChatSettingsPageState createState() => ChatSettingsPageState();
}

class ChatSettingsPageState extends State<ChatSettingsPage> {
  text tWid = text();
  @override
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double scaffoldWidth = constraints.maxWidth;
            return Consumer<AIEngine>(builder: (context, engine, child) {
              return Scaffold(
                appBar: AppBar(
                  leading: Padding(
                    padding: EdgeInsetsGeometry.only(left: 5),
                    child: IconButton(
                        onPressed: (){
                          engine.currentChat = "0";
                          engine.context.clear();
                          engine.contextSize = 0;
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_rounded)
                    ),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(engine.dict.value("chat_settings")),
                    ],
                  ),
                ),
                body: Builder(
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          divider.settings(
                              title: engine.dict.value("chat_name"),
                              context: context
                          ),
                          CardContents.static(
                              title: engine.chats[engine.currentChat]?["name"]??engine.dict.value("new_chat"),
                              subtitle: engine.dict.value("change_name")
                          )
                        ],
                      );
                    }
                ),
              );
            });
          }
      ),
    );
  }
}