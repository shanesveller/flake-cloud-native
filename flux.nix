{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.6.1";
in buildGoModule {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.6.1
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.6.1.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "1yhd7rl31z3hlsy1xnlffjssdk6rl6fwsm1yhiplnkvsqyzh96q3";
  };

  vendorSha256 = "eh5oUOLgZLIODL58WI1trXerHDWrIiclkrv/w0lvzL4=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.6.1/.goreleaser.yml#L6
  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=${version}" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    for shell in bash fish zsh; do
      $out/bin/flux completion $shell > flux.$shell
      installShellCompletion flux.$shell
    done
  '';

  meta = with lib; {
    description =
      "Kubernetes toolkit for assembling CD pipelines the GitOps way";
    homepage = "https://github.com/fluxcd/flux2";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
