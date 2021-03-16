class Game {
  final String playerName;
  int _score;
  bool _isInProgress = false;

  int get score => _score;
  bool get isInProgress => _isInProgress;

  Game({required this.playerName, score = 0}) : _score = score;

  start() {
    _score = 0;
    _isInProgress = true;
  }

  userScored() {
    if (_isInProgress) {
      _score++;
    }
  }

  finish() {
    _isInProgress = false;
  }
}
