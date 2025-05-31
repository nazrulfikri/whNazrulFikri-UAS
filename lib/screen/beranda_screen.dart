import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:whazlansaja/screen/model/dosen_model.dart';
import 'pesan_screen.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  List<DosenModel> dosenList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String response = await rootBundle
        .loadString('assets/json_data_chat_dosen/dosen_chat.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      dosenList = data.map((e) => DosenModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhNazrulFikri')),
      body: ListView.builder(
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          final lastMessage = dosen.details.isNotEmpty
              ? dosen.details.last.message
              : 'Belum ada chat';

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(dosen.img),
            ),
            title: Text(dosen.name),
            subtitle:
                Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
            onTap: () async {
              final updatedDosen = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PesanScreen(dosen: dosen),
                ),
              );

              if (updatedDosen != null) {
                setState(() {
                  dosenList[index] = updatedDosen;
                });
              }
            },
          );
        },
      ),
    );
  }
}
