class DecodeBarcode {
  String item;
  DecodeBarcode(this.item);
  DecodeBarcode.fromJson(parsedJson) {
    item = parsedJson['item'];
  }
}
