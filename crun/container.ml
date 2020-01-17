module Context = struct
  type t = {
    state_root: string;
    id: string;
    bundle: string;
    pid_file: string;
    detach: bool;
  }
  let create () = {
    state_root = "";
    id = "";
    bundle = "";
    pid_file = "";
    detach = false;
  }
end

let load_from_file ~file = if file = "" then `OK else `NG

let create =
  (* oci_container as def *)
  (* check config file *)
  (* if def.oci_version <> "1.0" then throgh error *)
  (* if (def->process && def->process->terminal && detach && context->console_socket == NULL)
    return crun_make_error (err, 0, "use --console-socket with --detach when a terminal is used"); *)

let run context =
  if not context.detach then
    

  
