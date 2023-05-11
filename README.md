# FormingFilterVowel

## Test ##

- decoupage_final.m

Ce code permet d'efectuer le filtrage d'un signal d'entrée choisit ici comme un son de synthétiseur de fréquence fixe.
L'intérêt premier est de pouvoir effectuer un changement entre deux filtres de voyelles différents de manière continue.
Afin de réaliser cela on effectue un fenêtrage en cosinus de notre signal d'entrée : deux cosinus de même forme mais décalé de la moitié de la taille de fenêtre permettent de découper le signal 
en fenêtres. On applique ensuite le filtre sur chaque fenêtre. La reconsitution du signal se fait par sommation des fenêtres et par concaténation. 
L'intérêt d'un telle méthode et de pouvoir changer de filtre entre chaque fenêtre, on peut donc faire évoluer les coefficients de nos filtres de manière linéaire afin d'obtenir une transition 
"smooth" entre les voyelles.

Une partie de tracé des figures est présente dans ce code. 


- filtre_aeiou.m

Il s'agit d'une fonction permettant l'obtention des coefficients des filtres voyelles. 
La méthode d'obtention des coefficients est tirée d'un code préexistantt.

- autres

Code Matlab nous ayant inspiré pour ce qui précède. 

## Src ##

- forming_filter.c

Ce code s'occupe de la gestion des filtres et de leur application sur l'entrée.
On considère un repère (X;Y) dans lequel chaque partie du plan est associée à un son voyelle. Lorsque l'on agit sur les potars, on déplace imaginairement un point dans ce plan, ce qui nous permet de sélectionner le filtre souhaité.
De plus, ce code s'appuie sur le code précédemment rédigé en Matlab pour le retranscrire en langage C (pour ensuite le rendre embarqué).
