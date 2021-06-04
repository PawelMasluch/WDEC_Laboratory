/* Zadanie 1 - stworzenie biblioteki (czyli referencji do katalogu) Lab5; Moje foldery -> (prawy przycisk myszy) -> Nowy... -> Folder -> Nazwa folderu: Lab5 -> OK  */
libname Lab5 '/folders/myfolders/Lab5'; /* nazwa biblioteki + ścieżka do tej biblioteki (Lab5->Właściwości) */
 
/* Zadanie 2 - załadowanie danych z pliku dane_4.txt do programu SAS; Lab5 -> Załaduj pliki... -> Ścieżka do pliku z danymi -> OK */
data Lab5.dane_lab5; /* miejsce, do którego pobieramy dane */
	infile '/folders/myfolders/Lab5/dane_4.txt' dlm = ";"; /* ścieżka do pliku tekstowego dane_4.txt z danymi do pobrania + powiedzenie, że średnik oodziela nasze dane w pliku dane_4.txt */
	input id text $ col1 col2 col3; /* nadanie nazw kolumnom danych, pochodzącym z pliku dane_4.txt; text $ oznacza, że kolumna text jest typu tekstowego, nazwa bez znaku $ za nim oznacza, że mamy typ liczbowy */
run; /* uruchomienie tego fragmentu kodu */
 
  
/* Zadanie 3 - stworzenie histogramów dla kolumn danych numerycznych col1, col2, col3*/
/* Wyniki widoczne w zakładce Rezultaty po wykonaniu się programu */
  
/* Histogram dla kolumny danych col1 */
PROC UNIVARIATE data = Lab5.dane_lab5; /* miejsce, z którego pobieramy dane do stworzenia histogramu */
	title 'Histogram - col1';
	VAR col1; /* dla kolumny col1 stworzymy histogram */
	HISTOGRAM col1; /* stworzenie histogramu dla kolumny col1 */
run; /* uruchomienie tego fragmentu kodu */
 
/* Histogram dla kolumny danych col2 */
PROC UNIVARIATE data = Lab5.dane_lab5; /* miejsce, z którego pobieramy dane do stworzenia histogramu */
	title 'Histogram - col2';
	VAR col2; /* dla kolumny col2 stworzymy histogram */
	HISTOGRAM col2; /* stworzenie histogramu dla kolumny col2 */
run; /* uruchomienie tego fragmentu kodu */

/* Histogram dla kolumny danych col3 */
PROC UNIVARIATE data = Lab5.dane_lab5; /* miejsce, z którego pobieramy dane do stworzenia histogramu */
	title 'Histogram - col3';
	VAR col3; /* dla kolumny col3 stworzymy histogram */
	HISTOGRAM col3; /* stworzenie histogramu dla kolumny danych col3 */
run; /* uruchomienie tego fragmentu kodu */



/* Zadanie 4 - Zależności kolumn ze zmiennymi numerycznymi col1, col2, col3, w zależności od kolumny id */

/* col1 = f(id) */
proc sgplot data = Lab5.dane_lab5;
	title 'Zależność kolumny col1 od kolumny id';
	scatter x = id y = col1; /* wykres punktowy */
run;

/* col2 = f(id) */
proc sgplot data = Lab5.dane_lab5;
	title 'Zależność kolumny col2 od kolumny id';
	scatter x = id y = col2; /* wykres punktowy */
run;

/* col3 = f(id) */
proc sgplot data = Lab5.dane_lab5;
	title 'Zależność kolumny col3 od kolumny id'; /* tytuł wykresu */
	scatter x = id y = col3; /* wykres punktowy */
run;




/* Zadanie 5 - Statystyki: N, MAX, MIN, NMISS, MEAN, za pomocą procedury MEANS */
PROC MEANS DATA = Lab5.dane_lab5 N MAX MIN NMISS MEAN;
title 'Parametry kolumn col1, col2, col3';
VAR col1 col2 col3; /* statystyki dla kolumn col1, col2, col3 */
RUN; 


/* Zadanie 6 - Statystyki oddzielnie dla id parzystych i nieparzystych z wykorzystaniem CLASS i
BY */

/* Wykorzystanie CLASS */
proc sort data = Lab5.dane_lab5;
by text;
run;

PROC MEANS DATA = Lab5.dane_lab5 /*N MAX MIN NMISS MEAN*/;
title 'Parametry kolumn col1, col2, col3, w zależności od text';
VAR col1 col2 col3;
CLASS text; /* dane w 1 tabeli */
RUN; 



/* Wykorzystanie BY */
proc sort data = Lab5.dane_lab5;
by text; 
run;

PROC MEANS DATA = Lab5.dane_lab5 /*N MAX MIN NMISS MEAN*/;
title 'Parametry kolumn col1, col2, col3, w zależności od text';
VAR col1 col2 col3;
BY text; /* dane w oddzielnych tabelach */
RUN; 

 

/* Zadanie 7 - Parametry a i b modelu regresji y = a + b*id dla id parzystych. */

/* col1 = f(id) */
PROC REG data = Lab5.dane_lab5;
title 'Zależność kolumny col1 od id - regresja liniowa dla id parzystych';
MODEL col1 = id;
where mod(id,2) = 0;
RUN; /* y=a+b*id dla b_col1_parz= -0.00024570, a_col1_parz = 1.70095 */

/* col2 = f(id) */
PROC REG data = Lab5.dane_lab5;
title 'Zależność kolumny col2 od id - regresja liniowa dla id parzystych';
MODEL col2 = id;
where mod(id,2) = 0;
RUN; /* y=a+b*id dla b_col2_parz= 0.00063185, a_col2_parz = -0.58791 */

/* col3 = f(id) */
PROC REG data = Lab5.dane_lab5;
title 'Zależność kolumny col3 od id - regresja liniowa dla id parzystych';
MODEL col3 = id;
where mod(id,2) = 0;
RUN; /* y=a+b*id dla b_col3_parz= 14.86533, a_col3_parz = 40.97727 */



/* Zadanie 8 - Dodaj kolumnę o nazwie ye zawierającą obliczona wartość z modelu regresji dla id
nieparzystych */


/* col1 */
/* col1 = f(id) */
PROC REG data = Lab5.dane_lab5;
title 'Zależność kolumny col1 od id - regresja liniowa dla id nieparzystych';
MODEL col1 = id;
where mod(id,2) = 1;
RUN; /* y= a + b*id dla b_col1_nparz = 0.00014486	, a_col1_nparz = 1.53692 */

/* wstawienie tabeli ye_col1_nparz */
data Lab5.dane_lab5;
set Lab5.dane_lab5;
b_col1_nparz = 0.00014486;
a_col1_nparz = 1.53692;
ye_col1_nparz = a_col1_nparz + b_col1_nparz * id;
where mod(id,2) =  1;  
run;
  

/* col2 */
/* col2 = f(id) */
PROC REG data = Lab5.dane_lab5;
title 'Zależność kolumny col2 od id - regresja liniowa dla id nieparzystych';
MODEL col2 = id;
where mod(id,2) = 1;
RUN; /* y= a + b*id dla b_col2_nparz = 0.00062574	, a_col2_nparz = 0.04208 */

/* wstawienie tabeli ye_col2_nparz */
data Lab5.dane_lab5;
set Lab5.dane_lab5;
b_col2_nparz = 0.00062574;
a_col2_nparz = 0.04208;
ye_col2_nparz = a_col2_nparz + b_col2_nparz * id;
where mod(id,2) =  1;  
run;


/* col3 */
/* col3 = f(id) */
PROC REG data = Lab5.dane_lab5;
title 'Zależność kolumny col3 od id - regresja liniowa dla id nieparzystych';
MODEL col3 = id;
where mod(id,2) = 1;
RUN; /* y=a*id+b dla a_col3_nparz = 14.95392	, b_col3_nparz = 54.22421 */

/* wstawienie tabeli ye_col3_nparz */
data Lab5.dane_lab5;
set Lab5.dane_lab5;
a_col3_nparz = 14.95392;
b_col3_nparz = 54.22421;
ye_col3_nparz = a_col3_nparz * id   +   b_col3_nparz;
where mod(id,2) =  1;  
run;



 
/* Zadanie 9 - Narysuj zależność y i ye od id nieparzystych dla 10, 100 i wszystkich obserwacji
(nieparzystych) */

/* col1 */
/* wszystkie punkty o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col1(id) oraz ye_col1_nparz(id) - wszystkie id nieparzyste'; /* tytuł wykresu */
	scatter x = id y = col1; /* wykres punktowy */
	scatter x = id y = ye_col1_nparz; /* wykres punktowy */
	where mod(id,2)=1;  
run;
 
/* 10 punktów o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col1(id) oraz ye_col1_nparz(id) - 10 punktów o id nieparzystym'; /* tytuł wykresu */
	scatter x = id y = col1; /* wykres punktowy */
	series x = id y = ye_col1_nparz; /* wykres liniowy */
	where mod(id,2)=1 and id <= 19;  
run;

/* 100 punktów o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col1(id) oraz ye_col1_nparz(id) - 100 punktów o id nieparzystym'; /* tytuł wykresu */
	scatter x = id y = col1; /* wykres punktowy */
	scatter x = id y = ye_col1_nparz; /* wykres punktowy */
	where mod(id,2) = 1 and id <= 199;  
run;



/* col2 */
/* wszystkie punkty o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col2(id) oraz ye_col2_nparz(id) - wszystkie id nieparzyste'; /* tytuł wykresu */
	scatter x = id y = col2; /* wykres punktowy */
	scatter x = id y = ye_col2_nparz; /* wykres punktowy */
	where mod(id,2)=1;  
run;

/* 10 punktów o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col2(id) oraz ye_col2_nparz(id) - 10 punktów o id nieparzystym'; /* tytuł wykresu */
	scatter x = id y = col2; /* wykres punktowy */
	series x = id y = ye_col2_nparz; /* wykres liniowy */
	where mod(id,2)=1 and id <= 19;  
run;

/* 100 punktów o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col2(id) oraz ye_col2_nparz(id) - 100 punktów o id nieparzystym'; /* tytuł wykresu */
	scatter x = id y = col2; /* wykres punktowy */
	scatter x = id y = ye_col2_nparz; /* wykres punktowy */
	where mod(id,2) = 1 and id <= 199;  
run;



/* col3 */
/* wszystkie punkty o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col3(id) oraz ye_col3_nparz(id) - wszystkie id nieparzyste'; /* tytuł wykresu */
	scatter x = id y = col3; /* wykres punktowy */
	scatter x = id y = ye_col3_nparz; /* wykres punktowy */
	where mod(id,2)=1;  
run;
 
/* 10 punktów o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col3(id) oraz ye_col3_nparz(id) - 10 punktów o id nieparzystym'; /* tytuł wykresu */
	scatter x = id y = col3; /* wykres punktowy */
	series x = id y = ye_col3_nparz; /* wykres liniowy */
	where mod(id,2)=1 and id <= 19;  
run;

/* 100 punktów o id nieparzystym */
proc sgplot data = Lab5.dane_lab5;
	title 'col3(id) oraz ye_col3_nparz(id) - 100 punktów o id nieparzystym'; /* tytuł wykresu */
	scatter x = id y = col3; /* wykres punktowy */
	scatter x = id y = ye_col3_nparz; /* wykres punktowy */
	where mod(id,2) = 1 and id <= 199;  
run;