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
  version = "v3.28.8";

  src = fetchFromGitHub {
    owner = "theRookieCoder";
    repo = pname;
    rev = version;
    sha256 = "sha256-YiK1LErR92grGN9gYGn6ozm+19+gEqRmFBHnItibL+g=";
  };

  cargoSha256 = "sha256-flPy73tN8Jvvggbg3dpEYhoSXpfdntloHoSg3C2yBRw=";
  
  # Do not build the gui part of the package.
  buildNoDefaultFeatures = true;

  # Tests are highly impure, accessing several pages
  # directly (modrinth, cloudflare, github).
  doCheck = false;

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description = "A CLI minecraft mod manager";
    homepage = "https://github.com/theRookieCoder/ferium";
    license = licenses.mpl20;
  };
}
