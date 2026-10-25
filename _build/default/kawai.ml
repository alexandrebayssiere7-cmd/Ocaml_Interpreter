let () =
  let file = Sys.argv.(1) in
  let c = open_in file in
  let lb = Lexing.from_channel c in
  Lexing.set_filename lb file;
  match Runner.run lb with
  | Ok () -> exit 0
  | Error msg -> Printf.eprintf "File \"%s\", %s\n" file msg; exit 1
  | exception e -> Printf.eprintf "Anomaly: %s\n" (Printexc.to_string e); exit 2
