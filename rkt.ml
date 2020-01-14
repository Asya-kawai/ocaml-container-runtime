(* rkt のデータ型 *)

module Command = struct
  type t = {
    usage: string;
    short: string;
    long: string;    
  }
  let create
      ?(usage="rkt [command]")
      ?(short="")
      ?(long=("A CLI running app containers on Linux.\n\n" ^
              "To get the help any specific command, run 'rkt help command'"))
      () =
    {
      usage;
      short;
      long;
    }
  let set_usage t usage_str = { t with usage = usage_str }
  let bash_completion_func t f = f t
  let missing_command help_func =
    Printf.eprintf "missing command\n%s" (help_func ())

  let exec t commands = Unix.create_process "rkt" commands Unix.stdin Unix.stdout Unix.stderr
end

(**
func main() {
	// check if rkt is executed with a multicall command
	multicall.MaybeExec()

	cmdRkt.SetUsageFunc(usageFunc)

	// Make help just show the usage
	cmdRkt.SetHelpTemplate(`{{.UsageString}}`)

	if err := cmdRkt.Execute(); err != nil && cmdExitCode == 0 {
		// err already printed by cobra on stderr
		cmdExitCode = 254 // invalid argument
	}
	os.Exit(cmdExitCode)
}
*)
