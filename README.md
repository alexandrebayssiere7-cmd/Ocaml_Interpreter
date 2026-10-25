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

`runner.ml` enchaîne ces étapes ; il est partagé par l'exécutable en ligne de
commande (`kawai.ml`) et par l'interface web (`web/`).

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
dune build ./kawai.exe
./kawai.exe tests/extend.kwa
```

## Interface web

`web/` contient un playground : un guide du langage, un éditeur et l'exécution
du code dans le navigateur. L'interpréteur OCaml est compilé en JavaScript avec
[js_of_ocaml](https://ocsigen.org/js_of_ocaml/) et tourne dans un Web Worker,
ce qui permet d'interrompre une boucle infinie au bout de 3 secondes.

```sh
opam install dune menhir js_of_ocaml
dune build --profile release ./web/kawa_web.bc.js
python3 -m http.server -d web 8000   # puis ouvrir http://localhost:8000
```

Il faut passer par un serveur HTTP : les navigateurs bloquent les Web Workers
ouverts depuis `file://`.

## Tests

```sh
./run_tests.sh
```

- `tests/*.kwa` et `web/examples/*.kwa` : la sortie doit correspondre au fichier
  `.expected` voisin. Les exemples du playground sont donc toujours valides.
- `tests/errors/*.kwa` : programmes invalides qui doivent être rejetés
  (erreur de syntaxe, de typage ou d'exécution).
