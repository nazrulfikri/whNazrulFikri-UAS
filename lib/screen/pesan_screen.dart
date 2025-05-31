import 'package:flutter/material.dart';
import 'package:whazlansaja/screen/model/dosen_model.dart';

class PesanScreen extends StatefulWidget {
  final DosenModel dosen;
  const PesanScreen({super.key, required this.dosen});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<ChatDetail> _chatList;

  @override
  void initState() {
    super.initState();
    _chatList = [...widget.dosen.details];
  }

  void _kirimPesan() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _chatList.add(ChatDetail(role: "saya", message: _controller.text.trim()));
      _controller.clear();
    });

    widget.dosen.details.clear();
    widget.dosen.details.addAll(_chatList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dosen.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.dosen.copyWith(details: _chatList));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _chatList.length,
              itemBuilder: (context, index) {
                final chat = _chatList[index];
                final isMe = chat.role == "saya";

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[200] : Colors.green[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(chat.message),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: "Ketikkan pesan"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _kirimPesan,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
