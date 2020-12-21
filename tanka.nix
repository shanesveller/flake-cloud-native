# based on upstream
{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.13.0";
in buildGoModule {
  pname = "tanka";
  inherit version;

  # https://github.com/grafana/tanka/releases/latest
  # https://github.com/grafana/tanka/releases/tag/v0.13.0
  # nix-prefetch-url --unpack https://github.com/grafana/tanka/archive/v0.13.0.tar.gz
  src = fetchFromGitHub {
    owner = "grafana";
    repo = "tanka";
    rev = "v${version}";
    sha256 = "1vmid8fjnv6hai6629n0mf1bf36rpzbqc23gf1mj3rq38xd02zf0";
  };

  vendorSha256 = "BnhKrrPgIQQMJkYley2/LmNRcAGOkpM4jpvREF4xIt8=";

  doCheck = false;

  buildFlagsArray = [ "-ldflags=-s -w -X main.Version=${version}" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    echo "complete -C $out/bin/tk tk" > tk.bash
    installShellCompletion tk.bash
  '';

  meta = with lib; {
    description = "Flexible, reusable and concise configuration for Kubernetes";
    homepage = "https://github.com/grafana/tanka/";
    license = licenses.asl20;
    maintainers = with maintainers; [ mikefaille ];
    platforms = platforms.unix;
  };
}
