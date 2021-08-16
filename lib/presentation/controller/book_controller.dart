import 'package:get/get.dart';
import 'package:hollywings/data/models/book/book_request.dart';
import 'package:hollywings/data/models/book/book_response.dart';
import 'package:hollywings/data/repositories/book_data_source.dart';

class BookController extends GetxController {
  var listBook = <BookResponse>[].obs;
  var book = BookResponse().obs;
  var state = ''.obs;

  void getAllBook() async {
    state.value = 'Loading';
    var result = await BookDataSourceApi().getAllBook();
    listBook.value = result;
    if (listBook.value == null) {
      state.value = 'NoData';
    } else {
      state.value = 'HasData';
    }
    listBook.refresh();
  }

  void submitDataBook(BookRequest request, int id) async {
    var result;
    if (id == null) {
      result = await BookDataSourceApi().insertBook(request);
      book.value = result;
      getAllBook();
      Get.back();
    } else {
      result = await BookDataSourceApi().updateBook(request, id);
      if (result.id == id) {
        book.value = result;
        getAllBook();
        Get.back();
      } else {
        state.value = 'Error';
      }
    }
  }
}
