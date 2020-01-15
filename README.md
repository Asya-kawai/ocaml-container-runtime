# コンテナランタイムとは
- コンテナを動作させる仕組み
- OCI にてコンテナの標準仕様を策定
- OCI v1.0に限って言えば以下の2つがある
  - コンテナランタイムの仕様に関する「Runtime Specification v1.0」
  - コンテナイメージの仕様に関する「Image Specification v1.0」
  
- 参照： k8s完全ガイド
  - k8s 完全ガイドには Format Speficication v1.0 と書いていたが、公式には「Image Specifiction v1.0」と書いている
- 参考: https://www.opencontainers.org/about

# コンテナランタイムの歴史
- もともとはLXCにて動作していた
- Docker社のコンテナランタイムDockerが注目を集める
- 様々なコンテナランタイムが登場
- 市場の成長に伴って、OCIとして標準化する仕組みが整っていった
- k8sの人気が爆発
  - k8sは当初からDockerエンジンを利用していた
  - つまりk8s上で利用できるコンテナランタイムはDockerが必要だった
  - 他のコンテナランタイムを動作させるためにはインターフェース仕様が必要になった
  - これがCRI策定の動きにつながる

- 参照： https://www.infoq.com/jp/articles/container-runtimes-kubernetes/

# コンテナランタイムの資料として使えそう
- https://medium.com/nttlabs/container-runtime-d3e25189f67a


# runcの実装
- 内部で app.Run(os.Args) している
- appは github.com/urfave/cli が本体
- main.goが本体
- app.goのapp.Runは 内部で RunContextを実行
  - https://github.com/urfave/cli/blob/3b8f4b9b2222814b74f48271b46ee8f9b6a4306c/app.go#L216
- app.goのRunContext内で、command.Run を実行
  - https://github.com/urfave/cli/blob/796ffdc72a971e098cf06a1cd9211c67c6d62a89/command.go#L89
- command.Run内では、command.startAppを実行(subcommandがあれば)
  - startApp内では、RunAsSubcommandを実行
- それ以外は、ActionFuncを実行（これは関数）
- では ActionFuncにどのような関数を入れるのか
  - checkpointCommand,
  - createCommand,
  - deleteCommand,
  - eventsCommand,
  - execCommand,
  - initCommand,
  - killCommand,
  - listCommand,
  - pauseCommand,
  - psCommand,
  - restoreCommand,
  - resumeCommand,
  - runCommand,
  - specCommand,
  - startCommand,
  - stateCommand,
  - updateCommand,
- 

# rktの実装
- mainは https://github.com/rkt/rkt/blob/master/rkt/main.go
- 流れは、
  - multicall.MaybeExec
  - cmdRkt.SetUsageFunc
  - cmdRkt.SetHelpTemplate
  - cmdRkt.Execute
    - エラーであれば、254を返す
    - それ以外は、cmdExitCodeを内部でセットしてそれを os.Exitとして返す
- cmdRktの実体は cobraというコマンドラインツール
- Executeはここ https://github.com/rkt/rkt/blob/a2f63178ee7749a4e90a2882744774dbd03bb425/vendor/github.com/spf13/cobra/command.go#L609
  - 実際は cobra のexecuteかな
- その中では、*Command.ExecuteCを呼び出している https://github.com/rkt/rkt/blob/a2f63178ee7749a4e90a2882744774dbd03bb425/vendor/github.com/spf13/cobra/command.go#L614
  - 色々フラグとか処理して、単純にcmd.Executeしているみたい

- runの実体はここ https://github.com/rkt/rkt/blob/4080b1743e0c46fa1645f4de64f1b75a980d82a3/rkt/run.go#L178

- 予想
  - rktは本当にプロセスをrunするだけ
  - appはイメージのリストとかやってくれる
  - appみたいなコマンドをrktに追加するような形で実装しているだけ

# rktのアーキテクチャ
- https://github.com/rkt/rkt/blob/162450f29427dd618601dc84914a0597f873d9b9/Documentation/devel/architecture.md

# ocaml-container-runtimeの実装
- ocaml-getopt をコピーする https://github.com/Asya-kawai/ocaml-getopt.git

# OCIの runtime仕様
- https://github.com/opencontainers/runtime-spec
- 日本語の資料だとこれとかわかりやすい https://thinkit.co.jp/article/14032
