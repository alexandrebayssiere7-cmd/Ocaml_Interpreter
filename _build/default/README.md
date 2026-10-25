# Kawa

Interpréteur en OCaml pour **Kawa**, un petit langage orienté objet inspiré de Java :
variables globales, classes avec attributs et méthodes, héritage simple avec
redéfinition, constructeurs, `if`/`else`, `while` et `return`.

```
var paire p;

class paire {
  attribute int x;
  attribute int y;

  method void constructor(int x, int y) {
    this.x = x;
    this.y = y;
  }

  method int somme() {
    return this.x + this.y;
  }
}

main {
  p = new paire(1, 2);
  print(p.somme());   // 3
}
```

## Architecture

Un programme `.kwa` traverse quatre étapes :

| Étape | Fichier | Rôle |
|---|---|---|
| Analyse lexicale | `kawalexer.mll` (ocamllex) | Texte → tokens |
| Analyse syntaxique | `kawaparser.mly` (Menhir) | Tokens → arbre syntaxique défini dans `kawa.ml` |
| Typage | `typechecker.ml` | Rejette les programmes mal typés avant l'exécution |
| Évaluation | `interpreter.ml` | Exécute l'arbre |

`kawai.ml` enchaîne ces étapes et affiche les erreurs avec leur position.

Points notables :
- **Typage** : sous-typage par héritage, détection des cycles d'héritage, vérification
  que toute méthode non `void` renvoie une valeur sur tous les chemins, contrôle du
  nombre et du type des arguments.
- **Évaluation** : liaison dynamique des méthodes (une redéfinition masque la méthode
  héritée), constructeurs hérités, objets comparés par identité, erreurs d'exécution
  explicites (division par zéro, accès à `null`).

## Compiler et lancer

Prérequis : OCaml, `dune` et `menhir` (`brew install ocaml dune menhir` ou `opam install dune menhir`).

```sh
dune build
./kawai.exe tests/extend.kwa
```

## Tests

```sh
./run_tests.sh
```

- `tests/*.kwa` : la sortie doit correspondre au fichier `.expected` voisin.
- `tests/errors/*.kwa` : programmes invalides qui doivent être rejetés
  (erreur de syntaxe, de typage ou d'exécution).
