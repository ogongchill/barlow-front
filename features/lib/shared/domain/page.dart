class Page {

  final int _size;
  final int _index;

  Page({int? size, int? index})
      : _size = size ?? 10,
        _index = index ?? 0;

  Page next() {
    return Page(size : _size, index : _index + 1);
  }

  int get index => _index;

  int get size => _size;
}