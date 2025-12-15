import 'package:flutter/material.dart';

class ManageWorkersCard extends StatelessWidget {
  final TextEditingController workerNameController;
  final TextEditingController workerLocController;
  final VoidCallback onAddWorker;

  const ManageWorkersCard({
    Key? key,
    required this.workerNameController,
    required this.workerLocController,
    required this.onAddWorker,
  }) : super(key: key);

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add ASHA Worker", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(controller: workerNameController, decoration: _inputDecoration("Worker Name")),
            const SizedBox(height: 12),
            TextField(controller: workerLocController, decoration: _inputDecoration("Location")),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onAddWorker,
              icon: const Icon(Icons.person_add),
              label: const Text("Add Worker"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
