{ lib, 
  fetchgit,
  pkgs,
  stdenv, 
}:

stdenv.mkDerivation {
  name = "nsxiv-extra";
  # version = "2023-10-02";
  src = fetchgit {
    url = "https://codeberg.org/nsxiv/nsxiv-extra/";
    sha256 = "sha256-rZt0F+xOVQgmcfET+v8+bpOEHOezBNzHi0O0Bo7qsCo=";
  };

  dontBuild = true;

  installPhase = ''
    sed -i 's|fuse-archive|${pkgs.fuse-archive}/bin/fuse-archive|' scripts/nsxiv-cb/nsxiv-cb
    
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-anti-alias/nsxiv-anti-alias
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-env/nsxiv-env
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-fill/nsxiv-fill
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-open/nsxiv-open
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-pipe/nsxiv-pipe
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-saver/nsxiv-saver
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-thumb/nsxiv-thumb
    sed -i 's/nsxiv/& -a/' scripts/nsxiv-url/nsxiv-url
    # sed -i 's/nsxiv/& -a/' scripts/nsxiv-rifle/nsxiv-rifle
    # sed -i 's/nsxiv/& -a/' scripts/nsxiv-cb/nsxiv-cb

    install -Dm755 -t $out/bin scripts/nsxiv-anti-alias/nsxiv-anti-alias
    install -Dm755 -t $out/bin scripts/nsxiv-env/nsxiv-env
    install -Dm755 -t $out/bin scripts/nsxiv-fill/nsxiv-fill
    install -Dm755 -t $out/bin scripts/nsxiv-open/nsxiv-open
    install -Dm755 -t $out/bin scripts/nsxiv-pipe/nsxiv-pipe
    install -Dm755 -t $out/bin scripts/nsxiv-rifle/nsxiv-rifle
    install -Dm755 -t $out/bin scripts/nsxiv-saver/nsxiv-saver
    install -Dm755 -t $out/bin scripts/nsxiv-thumb/nsxiv-thumb
    install -Dm755 -t $out/bin scripts/nsxiv-url/nsxiv-url
    install -Dm755 -t $out/bin scripts/nsxiv-cb/nsxiv-cb
  '';

   meta = with lib; {
    description = "Scripts that provide extra functionality to nsxiv.";
    homepage = "https://codeberg.org/nsxiv/nsxiv-extra";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ me ];
  };
}
