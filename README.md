# Kawa

Projet Interpreteur kawa Readme

Fichiers complétés : 

    - Nous avons complété les fichiers Kawalexer.ml, Kawaparser.mly pour ce qui est de l'analyse syntaxique, Typechecker.ml pour
    l'analyse de type et enfin le fichier interpreter.ml qui est le programme que l'on exécute, notre interpreteur.

Difficultés rencontrées : 

    -Nous avons rencontré quelques difficultés dans le fichier kawaparser.mly, notamment pour les fonctions class_def et methode_def, pour lesquelles le mot clé list nous a causé bien du tord. Enfin, la chose qui nous a sans doute ralenti le plus est que nous avions pas été tres réguliers sur la notation des token et en débuguant il y avait pas mal de tokens non définis ou dont les noms n'étaient pas exactement les même. 

Compilation/execution : 

    -Nous avons réussi à compiler le projet, mais le programme kawai.exe plante souvent a l'execution pour des raisons que nous ignorons car il plante parfois pour le simple symbol VAR qui est pourtant bien implémenté dans le lexer et le parser.

Extensions :
    
    -Nous n'avons pas fait d'extensions car nous avons pas reussi à executer le programme sans. On a donc passé le temps restant à essayer de régler le problème et à peaufiner çe qu'on avait déjà fait.