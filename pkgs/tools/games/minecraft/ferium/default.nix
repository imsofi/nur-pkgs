{ stdenv
, fetchFromGitHub
, rustc
, cargo 
, rustPlatform
, pkg-config
, lib
}:

rustPlatform.buildRustPackage rec {
  pname = "ferium";
  version = "4.1.1";

  src = fetchFromGitHub {
    owner = "gorilla-devs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-5DYdeK6JdA7oLBkjP3WkwLwlBitdf4Yt2dNP7P0INN0=";
  };

  patches = [ ./0001-Remove-std-process-ExitCode.patch ];

  cargoSha256 = "sha256-7rpxHfe+pWarPJ72WSXjgr63YctZ5+RrsEgmw7o66VI=";
  
  # Do not build the gui part of the package.
  buildNoDefaultFeatures = true;

  # Tests are highly impure, accessing several websites.
  # Assuming upstream ensures all tests run correctly before
  # tagging a release.
  doCheck = false;

  # Sanity check that the compiled binary actually runs
  # without any errors.
  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/ferium --help > /dev/null
  '';

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description = "A CLI minecraft mod manager";
    homepage = "https://github.com/theRookieCoder/ferium";
    license = licenses.mpl20;
    maintainers = with maintainers; [ imsofi ];
    platforms = platforms.linux;
  };
}