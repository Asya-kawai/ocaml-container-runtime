module Config = struct
  type t = {
    data_dir: string;
    system_config_dir: string;
    local_config_dir: string;
    user_config_dir: string;
    debug: bool;
    cpu_profile: string;
    memory_profile: string;
  }
  let init () = {
    data_dir = "/var/lib/rkt";
    system_config_dir = "/usr/lib/rkt";
    local_config_dir = "/usr/lib/rkt";
    user_config_dir = "";
    debug = false;
    cpu_profile = "";
    memory_profile = "";
  }
end


let get_config =
