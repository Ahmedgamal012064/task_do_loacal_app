abstract class Notestates {
}
class Noteinit extends Notestates {}
class Noteerror extends Notestates {
  final String errMessage;
  Noteerror(this.errMessage);
}
class Noteempty extends Notestates {}
class Noteloading extends Notestates {}
class Notesuccess extends Notestates {}




