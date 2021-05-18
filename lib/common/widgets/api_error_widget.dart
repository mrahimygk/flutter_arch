import 'package:flutter/material.dart';

class ApiErrorWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback onRetryClick;


  ApiErrorWidget(this.errorText, this.onRetryClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        children: [
          Column(
            children: [
              Icon(Icons.error),
              Text("Error", style: TextStyle(fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(errorText),
              ),
              TextButton(
                  onPressed: () {
                    onRetryClick();
                  },
                  child: Text("Retry"))
            ],
          )
        ],
      ),
    );
  }
}