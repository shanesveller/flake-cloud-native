{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.7.4";
in buildGoModule {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.7.4
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.7.4.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "110fb9h7h7hrflrrvwll04ymirrhciq8szm6g54msdjvffp61r4i";
  };

  vendorSha256 = "qylWQWZfdyYV4LVWBJxcHs/jPhfxIB8VYTpgwVwx0s8=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.7.4/.goreleaser.yml#L6
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
