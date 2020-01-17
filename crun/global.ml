(* How to use in repl.
   
   1. コンパイル済みオブジェクトコードファイル を生成する
     - ocamlfind ocamlc -c global.ml
   2. utop等のreplで読み込む
     2.1 global.mlと同じディレクトリにいる場合
       - #load "global.cmo";;
     2.2 global.mlと異なるディレクトリにいる場合
       - #directory "global.cmoがあるディレクトリ";;
       - #load "global.cmo";;
*)

(* init_libcrun_context に相当する *)
module Option = struct
  type t = {
    root: string;
    log: string;
    log_format: string;
    command: bool;
    debug: bool;
    system_cgroup: bool;
    force_no_root: bool;
  }
  let create ?(root="") ?(log="") ?(log_format="")
      ?(command=false) ?(debug=false)
      ?(system_cgroup=false) ?(force_no_root=false) () = {   
    root;
    log;
    log_format;
    command;
    debug;
    system_cgroup;
    force_no_root;
  }
end
