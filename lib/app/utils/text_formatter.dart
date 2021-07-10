import 'package:intl/intl.dart';

abstract class TextFormatter{
  static final _formatCurrency = NumberFormat.simpleCurrency();

  static String toCurrency(double value){
    return _formatCurrency.format(value);
  }

}