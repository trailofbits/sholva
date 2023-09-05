{
  inputs = {
    wiztoolkit = {
      url = "git+ssh://git@github.mit.edu/sieve-all/wiztoolkit.git?ref=jl/nix";
    };
  };
  outputs = { self, wiztoolkit, ... }: {
    programs.default = wiztoolkit.default;
  };
}
