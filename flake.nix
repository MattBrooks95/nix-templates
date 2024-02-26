{
  description = "templates to get subprojects started";

  outputs = { self }: {
    templates = {
      haskell-stack = {
        path = ./haskell-stack;
        description = "developer tools for a Haskell project with Stack";
      };
      haskell-cabal = {
        path = ./haskell-cabal;
        description = "developer tools for a Haskell project with Cabal";
      };
    };
  };
}
