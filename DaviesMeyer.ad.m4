
////////////////////////////////////////////////////////////////////////////////
// Davies Meyer Hash, generisch
//
// $1: Name der zu erzeugenden Klasse
// $2: Name der Blockchiffre


define(DaviesMeyer_Generic,


class $1
{
  longlong pruefSumme[4]; 
  longlong schluessel[4]; 
  int anzahlOktetsEingelesen;
methods:
  $1();

  void verarbeite(&char puffer[],int oktets);

  void gebePruefsumme(&char puffer32[]);

  int verarbeite(&String_16 dateiname);
};

)
