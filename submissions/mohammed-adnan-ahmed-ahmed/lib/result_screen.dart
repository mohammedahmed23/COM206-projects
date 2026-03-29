import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map result;

  const ResultScreen({super.key, required this.result});

  Color getColor(String res) {
    if (res == "SAFE") return Colors.green;
    if (res == "SUSPICIOUS") return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor(result["result"]);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Text(
                  "Scan Result",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.security, size: 50, color: color),

                  const SizedBox(height: 16),

                  Text(
                    result["result"],
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${result["score"]}/100",
                    style: TextStyle(color: color, fontSize: 32),
                  ),

                  const SizedBox(height: 16),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reasons",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Column(
                    children: (result["reasons"] as List)
                        .map(
                          (r) => Text(
                            "• $r",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recommendation",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    result["recommendation"],
                    style: TextStyle(color: color),
                  ),
                ],
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E1E),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Check Another Link"),
            ),
          ],
        ),
      ),
    );
  }
}
