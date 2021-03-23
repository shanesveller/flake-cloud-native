# based on upstream
{ buildGoModule, fetchFromGitHub, lib, installShellFiles }:

let version = "0.15.0";
in buildGoModule {
  pname = "tanka";
  inherit version;

  # https://github.com/grafana/tanka/releases/latest
  # https://github.com/grafana/tanka/releases/tag/v0.15.0
  # nix-prefetch-url --unpack https://github.com/grafana/tanka/archive/v0.15.0.tar.gz
  src = fetchFromGitHub {
    owner = "grafana";
    repo = "tanka";
    rev = "v${version}";
    sha256 = "05k9skxlgy4fy2bg5g2m56dzfra6vyzh404cbv0d2lyk3l6fyibj";
  };

  vendorSha256 = "vpm2y/CxRNWkz6+AOMmmZH5AjRQWAa6WD5Fnx5lqJYw=";

  doCheck = false;

  # https://github.com/grafana/tanka/blob/v0.15.0/Makefile#L17
  buildFlagsArray = [
    ''
      -ldflags=-s -w -extldflags "-static" -X github.com/grafana/tanka/pkg/tanka.CURRENT_VERSION=${version}''
  ];

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
