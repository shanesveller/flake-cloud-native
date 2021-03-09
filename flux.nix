{ buildGo116Module, fetchFromGitHub, lib, installShellFiles }:

let version = "0.9.1";
in buildGo116Module {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.9.1
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.9.1.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "0l6051w3w7y8qzw1ld3yxgd44mpmmvqdpbs2lpagblgy3crhplc4";
  };

  vendorSha256 = "NxgX4oavbLSxOF6hwUFvXnMLDmvX/v+We9MMYlgVaM4=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.9.1/.goreleaser.yml#L6
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
