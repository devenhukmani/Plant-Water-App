const int buttonPin = 2;
const int motor = 5;
const int sensorPin = A0;

int buttonState = 0;

void setup() {
    pinMode(buttonPin, INPUT);
    pinMode(motor, OUTPUT);

    Serial.begin(9600);
}

void loop() {
    buttonState = digitalRead(buttonPin);
    Serial.println(buttonState);

    if(buttonState == LOW){
        digitalWrite(motor, HIGH);
    }else{
        digitalWrite(motor, LOW);
    }

    Serial.println(analogRead(sensorPin));
}