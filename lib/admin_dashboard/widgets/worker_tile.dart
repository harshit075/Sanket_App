import 'package:flutter/material.dart';
import '../models/worker.dart';

class WorkerTile extends StatelessWidget {
  final Worker worker;

  const WorkerTile({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(worker.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${worker.location}\nReports Filed: ${worker.reportsFiled}"),
        isThreeLine: true,
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline, color: Colors.red),
        ),
      ),
    );
  }
}
