import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class BackendBloc extends Cubit<String> {
  BackendBloc() : super('');

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
    if (response.statusCode == 200) {
      emit(response.body);
    } else {
      emit('Failed to fetch data');
    }
  }
}