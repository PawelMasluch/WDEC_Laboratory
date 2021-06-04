# Parametry modelu
param cena1 = 100; # cena (za 1 godzinê zegarow¹) pracy konsultanta w 1. zespole 
param wsp1 = 2; # wspó³czynnik efektywnoœci konsultanta w 1. zespole 

param cena2 = 10; # cena (za 1 godzinê zegarow¹) pracy konsultanta w 2. zespole 
param wsp2 = 0.5; # wspó³czynnik efektywnoœci konsultanta w 2. zespole 

param q1prim = 30000; # oczekiwany koszt projektu
param q2prim = 500; # oczekiwany czas trwania projektu

param eps = 0.001; # epsilon w metodzie punktu odniesienia


# Zmienne decyzyjne
var x1; # czas pracy 1. konsultanta
var x2; # czas pracy 2. konsultanta

# Wyjœcia modelu
var q1; # ³¹czny koszt projektu
var q2; # ³¹czny czas projektu

# Zmienna pomocnicza
var z;


# Kryterium optymalizacji
maximize S: z + eps/2 * ( (-q1 + q1prim) + (-q2 + q2prim) );

# Ograniczenia
subject to o1: z <= -q1+ q1prim;
subject to o2: z <= -q2+ q2prim;
 
subject to o3: q1 = x1*cena1 + x2*cena2; # koszt realizacji projektu
subject to o4: q2 = x1 + x2; # czas realizacji projektu
 
subject to o5: wsp1*x1 >= 10; 
subject to o6: wsp2*x2 >= 20; 
subject to o7: 30 <= wsp1*x1 + wsp2*x2 <= 200;
