import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewNotificationToggle extends StatefulWidget {
  final String quizId;
  final bool initialValue;

  const ReviewNotificationToggle({
    required this.quizId,
    required this.initialValue,
    super.key,
  });

  @override
  State<ReviewNotificationToggle> createState() =>
      _ReviewNotificationToggleState();
}

class _ReviewNotificationToggleState extends State<ReviewNotificationToggle> {
  late bool _enabled;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _enabled = widget.initialValue;
  }

  Future<void> _toggle() async {
    final newValue = !_enabled;
    setState(() {
      _enabled = newValue;
      _loading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(widget.quizId)
          .update({'reviewEnabled': newValue});
    } catch (e) {
      setState(() {
        _enabled = !newValue;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Errore: $e")),
        );
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _loading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2))
          : Icon(
              _enabled ? Icons.notifications : Icons.notifications_off,
              color: Colors.black,
            ),
      onPressed: _loading ? null : _toggle,
    );
  }
}
