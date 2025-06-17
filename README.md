# Driver-Drowsiness
This project implements a real-time drowsiness detection system using MATLAB and your computer's webcam. It detects drowsy behavior based on eye blinks and yawns using Haar cascade classifiers.
How it Works

Captures video frames using your webcam.
Detects the face using the 'FrontalFaceCART' cascade detector.
Inside the face:
Detects eyes using 'EyePairBig'.
Detects mouth using 'Mouth'.
If eyes are closed for several consecutive frames → counts as blink.
If the mouth remains wide open for several frames → counts as yawn.
After a threshold of blinks or yawns, the system flags the user as drowsy.
