# Ein Feistel Chiffrierprogramm 

<img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Feistel_cipher_diagram_en.svg" alt="Alt-Text" width="240">

Das Feistel-Chiffren-Prinzip

<img src="https://upload.wikimedia.org/wikipedia/commons/5/53/Davies-Meyer_hash.svg" alt="Alt-Text" width="240">

Die kryptografisch starke Davies-Meyer Prüfsumme


Programm zum Verschlüsseln und zum Erzeugen von Prüfsummen, realisiert in der Programmiersprache SAPPEUR.
Die kryptografisch starke Prüfsumme wird mittels Davies-Meyer-Verfahren berechnet.

## Benutzung

### Verschlüsseln
c:\\> SprChiffre2.exe 10 SchillerGoetheVonDerVogelweide Klartext.txt

Dies erzeugt die verschlüsselte Datei Klartext.txt.spc. Es werden 10 Feistel-Runden gerechnet und der geheime Schlüssel ist "SchillerGoetheVonDerVogelweide".

### Entschlüsseln
c:\\> SprChiffre2.exe 10 SchillerGoetheVonDerVogelweide Klartext.txt.spc

Dies erzeugt die entschlüsselte Datei Klartext.txt

### Kryptografische Prüfsumme berechnen

c:\\> SprChiffre2.exe hash Klartext.txt


## Compiler
Den Sappeur-Compiler gibt es auf der Sappeur Homepage https://sappeur.di-fg.de

## Fertiges Programm zum Download
Fertiges Windows-Programm: 

https://github.com/DiplIngFrankGerlach/SprChiffre2/blob/main/Auslieferung/SprChiffre2.exe
https://github.com/DiplIngFrankGerlach/SprChiffre2/blob/main/PI/PiHex.txt
