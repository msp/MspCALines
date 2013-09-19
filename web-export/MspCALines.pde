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

// Wolfram Cellular Automata
// Daniel Shiffman <http://www.shiffman.net>

// A class to manage the CA

class CA {

  int[] cells;     // An array of 0s and 1s 
  int generation;  // How many generations?

  int[] ruleset;     // An array to store the ruleset, for example {0,1,1,0,1,1,0,1}

  int w = 2;

  CA(int[] r) {
    ruleset = r;
    cells = new int[width/w];
    restart();
  }

  // Make a random ruleset
  void randomize() {
    for (int i = 0; i < ruleset.length; i++) {
      ruleset[i] = int(random(2));
    }
  }

  // Reset to generation 0
  void restart() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
      //cells[i] = int(random(2));
    }
    cells[cells.length/2] = 1;    // We arbitrarily start with just the middle cell having a state of "1"
    generation = 0;
  }


  // The process of creating the new generation
  void generate() {
    // First we create an empty array for the new values
    int[] nextgen = new int[cells.length];
    // For every spot, determine new state by examing current state, and neighbor states
    // Ignore edges that only have one neighor
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];   // Left neighbor state
      int me = cells[i];       // Current state
      int right = cells[i+1];  // Right neighbor state
      nextgen[i] = rules(left, me, right); // Compute next generation state based on ruleset
    }
    // The current generation is the new generation
    cells = nextgen;
    generation++;
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) {
        fill(0);
        line(i*w, generation*w, generation*w, i*w);
      } else {
        fill(255);
        line(i*w, generation*w, i*w, generation*w);
      }
//      noStroke();
//      rect(i*w, generation*w, w, w);
//      ellipse(i*w, generation*w, w/2, w/2);
//      triangle(i*w, generation*w, generation*w/2, w/2, generation*w*3, w*3);
      
    }
  }

  // Implementing the Wolfram rules
  // This is the concise conversion to binary way
  /*int rules (int a, int b, int c) {
   String s = "" + a + b + c;
   int index = Integer.parseInt(s, 2);
   return ruleset[index];
   }*/
  // For JavaScript Mode
  int rules (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) return ruleset[0];
    if (a == 1 && b == 1 && c == 0) return ruleset[1];
    if (a == 1 && b == 0 && c == 1) return ruleset[2];
    if (a == 1 && b == 0 && c == 0) return ruleset[3];
    if (a == 0 && b == 1 && c == 1) return ruleset[4];
    if (a == 0 && b == 1 && c == 0) return ruleset[5];
    if (a == 0 && b == 0 && c == 1) return ruleset[6];
    if (a == 0 && b == 0 && c == 0) return ruleset[7];
    return 0;
  }

  // The CA is done if it reaches the bottom of the screen
  boolean finished() {
    if (generation > height/w) {
      return true;
    } 
    else {
      return false;
    }
  }
}


