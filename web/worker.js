// L'interpréteur tourne dans un worker : une boucle infinie ne bloque pas
// la page, qui peut l'interrompre en terminant le worker.
importScripts("kawa_web.bc.js");

onmessage = (e) => {
  const result = kawa.run(e.data);
  postMessage({ output: result.output, error: result.error });
};
