module M = struct
  type t = {
    data_dir: string;
    system_config_dir: string;
    local_config_dir: string;
    user_config_dir: string;
    debug: bool;
    cpu_profile: string;
    memory_profile: string;
  }
  let create
      ?(data_dir="/var/lib/rkt")
      ?(system_config_dir="/usr/lib/rkt")
      ?(local_config_dir="/usr/lib/rkt")
      ?(user_config_dir="") 
      ?(debug=false)
      ?(cpu_profile="")
      ?(memory_profile="")
      () =
    {
      data_dir;
      system_config_dir;    
      local_config_dir;
      user_config_dir;
      debug;
      cpu_profile;
      memory_profile;
    }
  let calculate_data_dir options =
    (* If --dir parameter is passed, then use this value. *)
    (**
    let dir_option = Getopt.M.Bool_t (BoolM.create ~short:"" ~long:"dir" ()) in
    let dir_t' = Getopt.parse ~options:options ~option_type:dir_option in
    let dir_t = Getopt.M.get_string_t ~t:dir_t' in dir_t.value
    *)
    (* #use "getopt.ml" *)
    let dir_option = M.Bool_t (BoolM.create ~short:"" ~long:"dir" ()) in
    let dir_t' = parse ~options:options ~option_type:dir_option in
    let dir_t = M.get_string_t ~t:dir_t' in dir_t.value
end
