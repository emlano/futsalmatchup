import 'package:flutter/material.dart';

void main() => runApp(FutsalMatchup());

class FutsalMatchup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visa Card Payment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VisaPaymentPage(),
    );
  }
}

class VisaPaymentPage extends StatefulWidget {
  @override
  _VisaPaymentPageState createState() => _VisaPaymentPageState();
}

class _VisaPaymentPageState extends State<VisaPaymentPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Visa Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: expiryDateController,
              decoration: InputDecoration(labelText: 'Expiry Date'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16),
            TextField(
              controller: cvvController,
              decoration: InputDecoration(labelText: 'CVV'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add payment processing logic here
                // For simplicity, let's assume payment is successful
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
                );
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
