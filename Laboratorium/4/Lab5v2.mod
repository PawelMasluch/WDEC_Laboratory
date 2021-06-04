# Parametry modelu
param M; # Liczba laptopow 
param N; # Liczba cech laptopow i kryteriow optymalizacji

# Cechy laptopow:
# 1 - cena laptopa (zl)
# 2 - ilosc pamieci RAM (GB)
# 3 - ilosc pamieci dyskowej (GB)
# 4 - dlugosc przekatnej ekranu (cale)
# 5 - czestoliwosc taktowania procesora (GHz)

# Macierz wartosci cech dla laptopow:
# K[i,j] -> wartosc j-tej cechy dla i-tego laptopa
param K{1..M, 1..N};

param eps; # Parametr w przedzialowej metodzie punktu odniesienia

param fi; # Parametr w przedzialowej metodzie punktu odniesienia

param ksi; # Parametr w przedzialowej metodzie punktu odniesienia

param R{1..N}; # Punkt rezerwacji

param A{1..N}; # Punkt aspiracji


# Zmienne decyzyjne
var x{1..M} binary; # zmienne binarne oznaczajace, czy wybralismy i-ty laptop (x_i = 1), czy nie (x_i = 0)


# Zmienne pomocnicze
var zz{1..M}; # minima funkcji ni (dla kazdego laptopa)
var z{1..M, 1..N}; # funkcje ni (dla kazddego laptopa, dla kazdej cechy)


# Cel optymalizacji
# Chcemy zminimalizowac cene (tj. ceche nr 1), przy jednoczesnej maksymalizacji pozostalych cech laptopa (tj. cechy 2-5)


# Kryterium optymalizacji
maximize S: sum{i in 1..M}( x[i] * zz[i] ) + eps/N * sum{i in 1..M, j in 1..N} ( x[i] * z[i,j] );


# Ograniczenia

# Wybieramy dokladnie 1 laptop
subject to o1: sum{i in 1..M} ( x[i] ) = 1;

# Przedzialowa metoda punktu odniesienia
subject to o2 {i in 1..M, j in 1..N}: zz[i] <= z[i,j]; 
subject to o3 {i in 1..M, j in 1..N}: z[i,j] <= fi * ( K[i,j] - R[j] ) / ( A[j] - R[j] );
subject to o4 {i in 1..M, j in 1..N}: z[i,j] <=  ( K[i,j] - R[j] ) / ( A[j] - R[j] );
subject to o5 {i in 1..M, j in 1..N}: z[i,j] <=  ( 1 + ksi * ( K[i,j] - A[j] ) / ( A[j] - R[j] ) );


