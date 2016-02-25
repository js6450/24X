String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete

int leoB = 2;
int jiwonB = 3;
int led = 13;

char inChar;

void setup() {
  // initialize serial:
  Serial.begin(9600);
  // reserve 200 bytes for the inputString:
  inputString.reserve(200);

  pinMode(leoB, INPUT);
  pinMode(jiwonB, INPUT);
  pinMode(led, OUTPUT);
}

void loop() {
  // print the string when a newline arrives:
  if (stringComplete) {
    Serial.println(inputString);
    // clear the string:
    inputString = "";
    stringComplete = false;
  }

  int leoState = digitalRead(leoB);
  int jiwonState = digitalRead(jiwonB);

  if(leoState == HIGH || jiwonState == HIGH){
    digitalWrite(led, HIGH);
    if(leoState == HIGH){
      inChar = 0;
    }
    if(jiwonState == HIGH){
      inChar = 1;
    }
  }
  else if (leoState == LOW && jiwonState == LOW){
    digitalWrite(led, LOW);
  }
}

/*
  SerialEvent occurs whenever a new data comes in the
 hardware serial RX.  This routine is run between each
 time loop() runs, so using delay inside loop can delay
 response.  Multiple bytes of data may be available.
 */
void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    }
  }
}


