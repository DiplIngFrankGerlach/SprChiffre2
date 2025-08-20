
dnl ////////////////////////////////////////////////////////////////////////////////
dnl // Davies Meyer Hash, generisch
dnl //
dnl // $1: Name der zu erzeugenden Klasse
dnl // $2: Name der Blockchiffre


define(DaviesMeyer_Generic,


$1::$1()
{
    //richte Pruefsumme mit PI ein
    pruefSumme[0] = cast(longlong,0x7e0d95748f728eb6);
    pruefSumme[1] = cast(longlong,0x58718bcd5882154a);
    pruefSumme[2] = cast(longlong,0xee7b54a41dc25a59);
    pruefSumme[3] = cast(longlong,0xb59c30d5392af260);

    for(var int j=0; j < 4; j++) { schluessel[j] = cast(longlong,0); }

    anzahlOktetsEingelesen = 0;
}

void $1::verarbeite(&char puffer[],int anzahlOktets)
{
   //var PrintfClass pfc;

   for(var int i=0; i < anzahlOktets; i++)
   {
      var int stelle = anzahlOktetsEingelesen & 31;

      stelle = stelle / 8;
      schluessel[stelle] = schluessel[stelle] | 
                           (cast(longlong,puffer[i]) & 0xFF); 
      
      var int aoe_m8 = anzahlOktetsEingelesen & 7;
      if( aoe_m8 < 7){ schluessel[stelle] = schluessel[stelle] << 8 ; }

      var int aoe_m32 = anzahlOktetsEingelesen & 31;

      //pfc.fstr("$1::verarbeite() i=$ anzahlOktetsEingelesen=$").sa(i).sa(anzahlOktetsEingelesen).pr();

      if( aoe_m32 == 31 )
      {
         //pfc.fstr("Schluessel: anzahlOktetsEingelesen:$").sa(anzahlOktetsEingelesen).pr();
         //for(var int j=0; j < 4; j++) { pfc.fstr("$ ").saHex(schluessel[j]).pr(); }

         var $2 chiffre(schluessel,16);

         chiffre.encipher(pruefSumme[0],pruefSumme[1]);
         chiffre.encipher(pruefSumme[2],pruefSumme[3]);

         for(var int j=0; j < 4; j++) { schluessel[j] = cast(longlong,0); }
      }
      anzahlOktetsEingelesen++;
   }
}

void $1::gebePruefsumme(&char puffer32[])
{
    var int m32 = anzahlOktetsEingelesen & 31;
    if( m32 != 0)
    {
        var int rest = 32 - m32;

        var char fuellPuffer[31];
        for(var int j=0; j < rest; j++) { fuellPuffer[j] = cast(char,0); }

        this.verarbeite(fuellPuffer,rest);
    }

    
    for(var int i=0; i < 32; i++) 
    { 
       var int im8 = i & 7;
       var longlong oktet = pruefSumme[i / 8] >> (im8*8);
       oktet = oktet & 0xFF;
       puffer32[i] = cast(char,oktet);
    }
}

int $1::verarbeite(&String_16 dateiname)
{
   var PrintfClass pfc;
   var SPRFile sfile(dateiname,1);

   if(sfile.systemHandle() < 1) 
   { 
      pfc.fstr("could not open file").pr();
      return -1; 
   }

   var char puffer[8192];

   var int pos = 0;
   var int ret;
   do
   {
      ret = sfile.read(pos,puffer.sz,puffer);
      if( ret > 0)
      {
         this.verarbeite(puffer,ret);
         pos = pos + ret;
      }
   }
   while(ret > 0);

   if(pos == 0)
   {
     pfc.fstr("could not read file").pr();
     return -2;
   }

   var char pruefSummeOktets[32];
   this.gebePruefsumme(pruefSummeOktets);
   
   for(var int i=0; i < 32; i++) { pfc.fstr("$").saHex(pruefSummeOktets[i]).prNoLF(); }

   return 1;
}



)
