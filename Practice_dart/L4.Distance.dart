void main() {
  Distance d1 = Distance.kms(3.4); //convert to meters
  Distance d2 = Distance.meters(1000);

  //print
  print("Distance in kms: ${d1.kms} kms");
  print("Distance in meters: ${d2.meters} meters");
  print("Result is: ${(d1 + d2).kms} kms");
 
}

class Distance {
  final double _meters;

  Distance.meters(double meters) : _meters = meters;
  Distance.kms(double kms) : _meters = kms * 1000;
  //getter
  double get meters => _meters;
  double get kms => _meters / 1000;

  Distance operator +(Distance other) {
    return Distance.meters(this.meters + other.meters);
  }
}
