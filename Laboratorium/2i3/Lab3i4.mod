# Parametry modelu

param f; # placa minimalna w firmie, w tys. zl‚
param n{1..5}; # liczba osob na stanowisku nr "i"
param m{1..5}; # pensja na stanowisku nr "i" w innych firmach
param p{1..5}; # referencyjna placa na stanowisku nr "i", wewnatrz firmy
param s{1..4}; # minimalna roznica plac miedzy stanowiskiem "i" oraz "(i+1)" 

param eps; # parametr w metodzie punktu odniesienia


# Punkt odniesienia
param q_prim{1..5}; # oczekiwane wartosci zmiennych q[1], ..., q[5] 


# Zmienne decyzyjne
var x{1..5}; # pensja (w tys. zl‚) na stanowisku nr "i"


# Zmienne pomocnicze

var delta_p_plus{1..5}; # odchylka dodatnia dla "p[i]" 
var delta_p_minus{1..5}; # odchylka ujemna dla "p[i]"

var delta_m_plus{1..5}; # odchylka dodatnia dla "m[i]" 
var delta_m_minus{1..5}; # odchylka ujemna dla "m[i]"

var z2; # zmienna pomocnicza dla zmiennej q2; q2 = z2
var z4; # zmienna pomocnicza dla zmiennej q4; q4 = z4
var z; # zmienna pomocnicza do metody punktu odniesienia, rowna min( -q[i] + q_prim[i] ): i=1..5



# Wyjscia modelu
var q{1..5}; 
# q[1] - suma plac w firmie, w tys. zl
# q[2] - maksymalne odchylenie od wewnetrznej struktury plac, w tys. zl
# q[3] - suma odchylen od wewnetrznej struktury plac, w tys. zl
# q[4] - maksymalne odchylenie od zewnetrznej struktury plac, w tys. zl
# q[5] - suma odchylen od zewnetrznej struktury plac, w tys. zl



# Kryterium optymalizacji

# Chcemy zminimalizowac wartosci q[1], ..., q[5], 
# zatem posluzymy sie optymalizacja wielokryterialna 
# za pomoca metody punktu odniesienia

maximize S: z + eps/5 * sum{i in 1..5} ( -q[i] + q_prim[i] );


# Ograniczenia

subject to o1: x[5] >= f; # na najnizszym stanowisku: placa >= placa minimalna 

subject to o2 {i in 1..4}: x[i] >= x[i+1] + s[i]; # warunek na gradacje plac (im wyzsze stanowisko, tym lepsza placa)

subject to o3 {i in 1..5}: x[i] = p[i] + delta_p_plus[i] - delta_p_minus[i]; # uzalezniamy pensje na stanowisku nr "i" od preferencji "p[i]" oraz odpowiednich odchylek

subject to o4 {i in 1..5}: x[i] = m[i] + delta_m_plus[i] - delta_m_minus[i]; # uzalezniamy pensje na stanowisku nr "i" od preferencji "m[i]" oraz odpowiednich odchylek


# Kryterium q1
subject to o5: q[1] = sum{i in 1..5} ( n[i]*x[i] ); # wzor na sume plac w firmie


# Kryterium q2
subject to o6: q[2] = z2;
subject to o7 {i in 1..5}: z2 >= delta_p_plus[i] + delta_p_minus[i];


# Kryterium q3
subject to o8: q[3] = sum{i in 1..5} ( delta_p_plus[i] + delta_p_minus[i] ); # suma odchylen od wewnetrznej struktury plac


# Kryterium q4
subject to o9: q[4] = z4;
subject to o10 {i in 1..5}: z4 >= delta_m_plus[i] + delta_m_minus[i];


# Kryterium q5
subject to o11: q[5] = sum{i in 1..5} ( delta_m_plus[i] + delta_m_minus[i] ); # suma odchylen od zewnetrznej struktury plac


# Odchylki
subject to o12 {i in 1..5}: delta_p_plus[i] >= 0;   
subject to o13 {i in 1..5}: delta_p_minus[i] >= 0;   

subject to o14 {i in 1..5}: delta_m_plus[i] >= 0;   
subject to o15 {i in 1..5}: delta_m_minus[i] >= 0;


# Ograniczenie w ramach kryterium optymalizacji
subject to o16 {i in 1..5}: z <= -q[i] + q_prim[i];

