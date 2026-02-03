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

  finish() {
    _isInProgress = false;
  }

  userScored() {
    if (_isInProgress) {
      _score++;
    }
  }
}
