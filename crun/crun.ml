(* https://github.com/containers/crun/blob/c11bfb920ef33184736b9716e051286d71219f7c/src/crun.c *)

(* ハンドラ型
   crunでいうところの ARGP に相当する。
   
   OPTIONS.  Field 1 in ARGP.
   Order of fields: {NAME, KEY, ARG, FLAGS, DOC}.

   ハンドラ型では上記のフィールドの内、NAME ARGのみ対応。

   それ以外にもハンドラ型で持つべき関数も追加している。   
*)
module Handler = struct
  type t = {
    name: string;
    command: string;
  }
  let create ?(name="") ?(command="") () = {
    name;
    command;
  }
  let empty = create ()
  let get_name t = t.name
  let get_command t = t.command
  let set_name t ~name = { t with name = name }
  let set_command t ~command = { t with command = command }
  let execute t f = f t.command
end

(* ハンドラはここで登録する *)
let handlers =
  let commands = [
    "create";
    "delete";
    "exec";
    "lsit";
    "kill";
    "ps";
    "run";
    "spec";
    "start";
    "stop";
    "update";
    "pause";
    "resume";
  ] in
  List.map (fun x -> Handler.create ~name:x ()) commands

(* ハンドラ取得用の関数
   引数にhandler_name:stringを指定し、
   ハンドラ型 Hanlder.t の nameフィールドと一致したHandler型を返す。
*)
let rec get_handler ~handler_name = function
  | [] -> Handler.empty
  | (x:Handler.t) :: (xs:Handler.t list) ->
    if handler_name = (Handler.get_name x) then x
    else get_handler handler_name xs

(* オプション型。未実装 *)
module Options = struct
  type t = {
    debug: bool;

    cgroup_manager: string;
    systemd_manager: string;

    log: string;
    log_format: string;

    root: string;
    rootless: string;
  }
end

(* エラー表示関数 *)
let exit_failure_with_error ~status_code ~error_message ~error_arg =
    Printf.eprintf error_message error_arg;
    exit status_code

(* main関数 *)
let () =
  let handler_name = Sys.argv.(1) in
  let handler = get_handler ~handler_name:handler_name handlers in
  if handler = Handler.empty then
    exit_failure_with_error
      ~status_code:0
      ~error_message:"unknown command %s\n" 
      ~error_arg: handler_name
  else
    let handler_args =
      Array.to_list Sys.argv |> List.filter (fun x -> x <> handler_name)
    in
    let handler = Handler.set_command handler handler_args in
    let return_code = Handler.execute handler (fun x -> x)
    


(*
argp_parse について

* http://crasseux.com/books/ctutorial/argp-example.html

```
/*
   OPTIONS.  Field 1 in ARGP.
   Order of fields: {NAME, KEY, ARG, FLAGS, DOC}.
*/

static struct argp_option options[] =
{
  {"verbose", 'v', 0, 0, "Produce verbose output"},
  {"alpha",   'a', "STRING1", 0,
   "Do something with STRING1 related to the letter A"},
  {"bravo",   'b', "STRING2", 0,
   "Do something with STRING2 related to the letter B"},
  {"output",  'o', "OUTFILE", 0,
   "Output to OUTFILE instead of to standard output"},
  {0}
};
```

詳細はこれ。
```
/*
   The ARGP structure itself.
*/
static struct argp argp = {options, parse_opt, args_doc, doc};

```

* KEYはoptions検索用のため不要とする
* ARGは実際の値なので、これは必要
* FLAGS
* DOCはできたらつける

*)

let crun_create options =
  
