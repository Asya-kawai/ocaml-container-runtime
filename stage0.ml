(* Run mounts the right overlay filesystems and actually runs the prepared
   pod by exec()ing the stage1 init inside the pod filesystem. *)
let run config dir data_dir =
  (* privateUsers, err := preparedWithPrivateUsers(dir) *)
  
  (* --- setup stage01 --- *)

  (* stage01用のイメージを作成 setup
     if err := setupStage1Image(cfg, dir, cfg.UseOverlay); err != nil {
		   log.FatalE("error setting up stage1", err)
	   }
  *)

  (* ここで仮想マシン上に作業用ディレクトリ作成完了通知
     debug("Wrote filesystem to %s\n", dir)
  *)

  (* アプリケーションイメージの生成 setup 
for _, app := range cfg.Apps {
		if err := setupAppImage(cfg, app.Name, app.Image.ID, dir, cfg.UseOverlay); err != nil {
			log.FatalE("error setting up app image", err)
		}
	}
*)

  (* なにかやっている
     destRootfs := common.Stage1RootfsPath(dir) 
     writeDnsConfig(&cfg, destRootfs)
  *)

  (* 環境変数に設定
if err := os.Setenv(common.EnvLockFd, fmt.Sprintf("%v", cfg.LockFd)); err != nil {
		log.FatalE("setting lock fd environment", err)
	}

	if err := os.Setenv(common.EnvSELinuxContext, fmt.Sprintf("%v", cfg.ProcessLabel)); err != nil {
		log.FatalE("setting SELinux context environment", err)
	}

	if err := os.Setenv(common.EnvSELinuxMountContext, fmt.Sprintf("%v", cfg.MountLabel)); err != nil {
		log.FatalE("setting SELinux mount context environment", err)
	}
*)

(* ここで作業ディレクトリに移動
debug("Pivoting to filesystem %s", dir)
	if err := os.Chdir(dir); err != nil {
		log.FatalE("failed changing to dir", err)
	}
*)

  (* エントリーポイントを取得。エントリーポイントをargs設定
	ep, err := getStage1Entrypoint(dir, runEntrypoint)
	if err != nil {
		log.FatalE("error determining 'run' entrypoint", err)
	}
	args := []string{filepath.Join(destRootfs, ep)}

	if cfg.Debug {
		args = append(args, "--debug")
	}
*)

  (* networkの設定
args = append(args, "--net="+cfg.Net.String())
*)

(* その他のオプションを諸々設定
if cfg.Interactive {
		args = append(args, "--interactive")
	}
	if len(privateUsers) > 0 {
		args = append(args, "--private-users="+privateUsers)
	}
	if cfg.MDSRegister {
		mdsToken, err := registerPod(".", cfg.UUID, cfg.Apps)
		if err != nil {
			log.FatalE("failed to register the pod", err)
		}

		args = append(args, "--mds-token="+mdsToken)
	}

	if cfg.LocalConfig != "" {
		args = append(args, "--local-config="+cfg.LocalConfig)
	}

	s1v, err := getStage1InterfaceVersion(dir)
	if err != nil {
		log.FatalE("error determining stage1 interface version", err)
	}

	if cfg.Hostname != "" {
		if interfaceVersionSupportsHostname(s1v) {
			args = append(args, "--hostname="+cfg.Hostname)
		} else {
			log.Printf("warning: --hostname option is not supported by stage1")
		}
	}

	if cfg.DNSConfMode.Hosts != "default" || cfg.DNSConfMode.Resolv != "default" {
		if interfaceVersionSupportsDNSConfMode(s1v) {
			args = append(args, fmt.Sprintf("--dns-conf-mode=resolv=%s,hosts=%s", cfg.DNSConfMode.Resolv, cfg.DNSConfMode.Hosts))
		} else {
			log.Printf("warning: --dns-conf-mode option not supported by stage1")
		}
	}

	if interfaceVersionSupportsInsecureOptions(s1v) {
		if cfg.InsecureCapabilities {
			args = append(args, "--disable-capabilities-restriction")
		}
		if cfg.InsecurePaths {
			args = append(args, "--disable-paths")
		}
		if cfg.InsecureSeccomp {
			args = append(args, "--disable-seccomp")
		}
	}

	if cfg.Mutable {
		mutable, err := supportsMutableEnvironment(dir)

		switch {
		case err != nil:
			log.FatalE("error determining stage1 mutable support", err)
		case !mutable:
			log.Fatalln("stage1 does not support mutable pods")
		}

		args = append(args, "--mutable")
	}

	if cfg.IPCMode != "" {
		if interfaceVersionSupportsIPCMode(s1v) {
			args = append(args, "--ipc="+cfg.IPCMode)
		} else {
			log.Printf("warning: --ipc option is not supported by stage1")
		}
	}

	args = append(args, cfg.UUID.String())
*)

(* 実行
// make sure the lock fd stays open across exec
	if err := sys.CloseOnExec(cfg.LockFd, false); err != nil {
		log.Fatalf("error clearing FD_CLOEXEC on lock fd")
	}
*)

  
