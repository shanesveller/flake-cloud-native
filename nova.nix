{ buildGoModule, fetchFromGitHub, lib }:
let version = "2.0.2";
in buildGoModule {
  pname = "nova";
  inherit version;

  # https://github.com/FairwindsOps/nova/releases/latest
  # https://github.com/FairwindsOps/nova/releases/tag/2.0.2
  # nix-prefetch-url --unpack https://github.com/FairwindsOps/nova/archive/2.0.2.tar.gz
  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = version;
    sha256 = "06gxzkms33xjgg06g4lxizq9imb09l76fgbw7nfcak8lqsy4h06i";
  };

  vendorSha256 = "6bonBYcksb+pCrx0EvL2CeHO6+SXA7Qzm4dd9tmtHF4=";

  subPackages = [ "." ];

  doCheck = false;

  meta = with lib; {
    description = "Find outdated or deprecated Helm charts running in your cluster.";
    homepage = "https://github.com/FairwindsOps/nova";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
