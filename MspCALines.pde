// Wolfram Cellular Automata
// Daniel Shiffman <http://www.shiffman.net>

// Simple demonstration of a Wolfram 1-dimensional cellular automata
// When the system reaches bottom of the window, it restarts with a new ruleset
// Mouse click restarts as well

CA ca;   // An object to describe a Wolfram elementary Cellular Automata

int delay = 0;

void setup() {
  size(800, 800);
  background(255);
  int[] ruleset = {
    0, 1, 0, 1, 1, 0, 1, 0
  };
  ca = new CA(ruleset);
  frameRate(30);
}

void draw() {
  ca.display();
  ca.generate();

  if (ca.finished()) {
//    delay++;
//    if (delay > 30) {
      background(255);
      ca.randomize();
      ca.restart();
      delay = 0;
//    }
  }
}

void mousePressed() {
//  background(255);
  ca.randomize();
  ca.restart();
}

