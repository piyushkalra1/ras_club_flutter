class ConferenceHallAccount {
  ConferenceHallAccount({
      this.message, 
      this.availablity, 
      this.costPerPlate, 
      this.totalAmount, 
      this.totalGST, 
      this.grandTotal, 
      this.advanceAmount, 
      this.advanceAmountPercentage, 
      this.advanceAmountPercentage1,});

  ConferenceHallAccount.fromJson(dynamic json) {
    message = json['Message'];
    availablity = json['Availablity'];
    costPerPlate = json['CostPerPlate'];
    totalAmount = json['TotalAmount'];
    totalGST = json['TotalGST'];
    grandTotal = json['GrandTotal'];
    advanceAmount = json['AdvanceAmount'];
    advanceAmountPercentage = json['AdvanceAmountPercentage'];
    advanceAmountPercentage1 = json['AdvanceAmountPercentage1'];
  }
  String ?message;
  String ?availablity;
  int ?costPerPlate;
  int ?totalAmount;
  int ?totalGST;
  int ?grandTotal;
  int ?advanceAmount;
  String ?advanceAmountPercentage;
  String ?advanceAmountPercentage1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Availablity'] = availablity;
    map['CostPerPlate'] = costPerPlate;
    map['TotalAmount'] = totalAmount;
    map['TotalGST'] = totalGST;
    map['GrandTotal'] = grandTotal;
    map['AdvanceAmount'] = advanceAmount;
    map['AdvanceAmountPercentage'] = advanceAmountPercentage;
    map['AdvanceAmountPercentage1'] = advanceAmountPercentage1;
    return map;
  }

}