/// *
/// Author         : Dicky Zulkarnain
/// Date           : 09/10/22
/// Original File  : extentions
///**/

extension ListExtention<E> on List<E> {
  E? find(bool Function(E element) predicate) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }
}