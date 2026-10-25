open Js_of_ocaml

(* Exécute un programme Kawa et renvoie à JavaScript un objet
   { output: sortie de print, error: message d'erreur ou "" }. *)
let run source =
  let out = Buffer.create 256 in
  Sys_js.set_channel_flusher stdout (Buffer.add_string out);
  let error =
    match Runner.run (Lexing.from_string (Js.to_string source)) with
    | Ok () -> ""
    | Error msg -> msg
    | exception e -> "anomaly: " ^ Printexc.to_string e
  in
  flush stdout;
  Js.Unsafe.obj [|
    "output", Js.Unsafe.inject (Js.string (Buffer.contents out));
    "error", Js.Unsafe.inject (Js.string error);
  |]

let () =
  Js.Unsafe.set Js.Unsafe.global "kawa"
    (Js.Unsafe.obj [| "run", Js.Unsafe.inject (Js.wrap_callback run) |])
