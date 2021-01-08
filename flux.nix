{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.5.9";
in buildGoModule {
  pname = "flux2";
  inherit version;

  # https://github.com/fluxcd/flux2/releases/latest
  # https://github.com/fluxcd/flux2/releases/tag/v0.5.9
  # nix-prefetch-url --unpack https://github.com/fluxcd/flux2/archive/v0.5.9.tar.gz
  src = fetchFromGitHub {
    owner = "fluxcd";
    repo = "flux2";
    rev = "v${version}";
    sha256 = "1fic1hgsjhail9p2ki7qqr0vl5av3gfb8y3h9ygzq4j869780bsq";
  };

  vendorSha256 = "m2GM5htbPJNgjQnVkQ1BL6cTKJH1ulQ79oDnEC8g9pc=";

  subPackages = [ "cmd/flux" ];

  doCheck = false;

  # https://github.com/fluxcd/flux2/blob/v0.5.9/.goreleaser.yml#L6
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
