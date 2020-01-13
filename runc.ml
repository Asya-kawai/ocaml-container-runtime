(**
   App is the main structure of a cli application. 
   It is recommended that
   an app be created with the cli.create function.
*)
(* cli.create にて作成する、runcのメインとなる構造体 *)
module App = struct
  type t = {
    (* The name of the program. Defaults to path.Base(os.Args[0]). *)
    name: string;
    (* Full name of command for help, defaults to Name. *)
    help_name: string;
    (* Description of the program.?? *)
    (* Description for usage.が正しいと思う *)
    usage: string;
    (* Text to override the USAGE section of help. *)
    usage_test: string;
    (* Description of the program argument format. *)
    args_usage: string;
    (* Version of the program. *)
    version: string;
    (* Description of the program. *)
    description: string;
    (* List of commands to execute. *)
    commands: string list;
    (* List of command flags to parse *)
    flags: string list;
    (* Boolean to enable bash completion commands *)
    enable_bash_completion: bool;
    (* categories contains the categorized commands and is populated on app startup. *)
    categories: string list;
    (* Compilation date *)
    compiled_at: string;
    (* List of all authors who contributed *)
    authors: string list;
    (* Copyright of the binary if any *)
    copyright: string;
    (* 標準出力と標準エラー出力はどのように扱うか。
       いまはレコード型として扱わず、必要になったら考えることにする。
       たぶん、呼び出し側で設定することになるかな。
    *)
    (* // Writer writer to write output to
	     Writer io.Writer
	     // ErrWriter writes error output
	     ErrWriter io.Writer
    *)
    (* Other custom info *)
    metadata: string list;
    (* Carries a function which returns app specific info. *)
    extra_data: string list;
    (* じっそうしなくてもよさそう。。。
       //CustomAppHelpTemplate the text template for app help topic.
       //cli.go uses text/template to render templates. You can
	     //render custom help text by setting this variable.
	     CustomAppHelpTemplate string
	     //Boolean to enable short-option handling so user can combine several
	     //single-character bool arguments into one
	     //i.e. foobar -o -v -> foobar -ov
	     UseShortOptionHandling bolo
    *)    
    did_setup: bool;
  }
  let create ?(name="") ?(help_name="") ?(usage="") ?(usage_test="")
      ?(args_usage="") ?(version="") ?(description="")
      ?(commands=[]) ?(flags=[]) ?(enable_bash_completion=false)
      ?(categories=[]) ?(compiled_at="") ?(authors=[]) ?(copyright="")
      ?(metadata=[]) ?(extra_data=[]) ?(did_setup=false)
      () =
    {
      name;
      help_name;
      usage;
      usage_test;
      args_usage;
      version;
      description;
      commands;
      flags;
      enable_bash_completion;
      categories;
      compiled_at;
      authors;
      copyright;
      metadata;
      extra_data;
      did_setup;
    }
  (* An action to execute when the shell completion flag is set *)
  let bash_complete f = f
  (* An action to execute before any subcommands are run,
     but after the context is ready
	   If a non-nil error is returned, no subcommands are run *)
  let before_func f = f
  (* An action to execute after any subcommands are run,
     but after the subcommand has finished
	   It is run even if action() panics *)
  let after_func f = f
  (* The action to execute when no subcommands are specified *)
  let action_func app f = f app
  (* Execute this function if the proper command cannot be found *)
  let command_nof_found_func f = f
  (* Execute this function if an usage error occurs *)
  let usage_error_func f = f
  (* Execute this function to handle ExitErrors.
     If not provided, HandleExitCoder is provided to
	   function as a default, so this is optional. *)
  let exit_err_func f = f
  (* どのように実装するかは要検討
     // Run is the entry point to the cli app. Parses the arguments slice and routes
     // to the proper flag/args combination
  *)
  let run = print_endline ""
end

(**
// Package cli provides a minimal framework for creating and organizing command line
// Go applications. cli is designed to be easy to understand and write, the most simple
// cli application can be written as follows:
//   func main() {
//     (&cli.App{}).Run(os.Args)
//   }
//
// Of course this application does not do much, so let's make this an actual application:
//   func main() {
//     app := &cli.App{
//			 Name: "greet",
//			 Usage: "say a greeting",
//			 Action: func(c *cli.Context) error {
//				 fmt.Println("Greetings")
//				 return nil
//			 },
//		 }
//
//     app.Run(os.Args)
//   }
*)
let () =
  let app = App.create ~name: "greet" ~usage: "say a greeting" () in  
  let f (x:App.t) = Printf.printf "greetings called by %s.\n" x.name in
  App.action_func app f
