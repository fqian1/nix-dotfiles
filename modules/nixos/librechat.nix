{ lib, pkgs, ... }: {
  # Allow MongoDB if using enableLocalDB
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "mongodb-ce"
  ];
  
  services.mongodb.package = pkgs.mongodb-ce;

  services.librechat = {
    enable = true;
    enableLocalDB = true; # This automatically sets MONGO_URI to localhost
    
    # This tells Systemd to load your file via EnvironmentFile=
    credentialsFile = "/var/lib/librechat/librechat.env";

    # # Optional: If you want to open the firewall
    # openFirewall = true;

    # The free-form settings for the librechat.yaml
    settings = {
      version = "1.2.1";
      # If you reference variables from the .env file in your yaml, 
      # use the ${VAR} syntax. Note: Nix requires escaping the '$'
      endpoints = {
        custom = [
          {
            name = "OpenRouter";
            # We use the variable name from your .env file.
            # The \$ escapes it so Nix doesn't try to evaluate it as a Nix variable.
            apiKey = "\${API_KEY}"; 
            baseURL = "https://openrouter.ai/api/v1";
            models = {
              default = [ 
              "deepseek/deepseek-r1" 
              ];
              fetch = true; # Set to true to attempt to pull other available models automatically
            };
            titleConvo = true;
            titleModel = "deepseek/deepseek-chat";
            summarize = true;
            summaryModel = "deepseek/deepseek-chat";
            forcePrompt = false;
            modelDisplayLabel = "OpenRouter (DeepSeek)";
          }
        ];
      };
    };
  };
}
