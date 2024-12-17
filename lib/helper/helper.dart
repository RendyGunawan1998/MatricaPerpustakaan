import 'package:flutter/material.dart';

hbox(double h) {
  return SizedBox(height: h);
}

wbox(double w) {
  return SizedBox(width: w);
}

tff(String label, TextEditingController? controller) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1,
          ),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter $label' : null);
}

tffNumber(String label, TextEditingController? controller) {
  return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1,
          ),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter $label' : null);
}

tffSynopsis(TextEditingController? controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: 'Synopsis',
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.black54,
          width: 1,
        ),
      ),
    ),
    maxLines: 3,
    validator: (value) =>
        value == null || value.isEmpty ? 'Enter synopsis' : null,
  );
}

buttonBlue(Function() ontap, IconData? icon, String text) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.lightBlue),
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: Colors.white),
            wbox(5),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ),
  );
}
