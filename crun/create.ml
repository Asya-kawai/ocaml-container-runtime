(* https://github.com/containers/crun/blob/c11bfb920ef33184736b9716e051286d71219f7c/src/create.c *)

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

module Option = struct
  type 'a t = {
    name: string;
    value: 'a;
    doc: string;
  }
  let create ?(name="") ?(doc="") ~value () = {
    name;
    value;
    doc;
  }
  let set_name t ~name = { t with name }
  let set_doc t ~doc = { t with doc }
end

let run = 
  (* TODO: bundle 実装すること *)
  
