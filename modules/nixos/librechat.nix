{...}: {
  services.librechat = {
    enable = true;

    # 1. Database: The easiest way is to let the module handle a local MongoDB.
    enableLocalDB = true;

    # 2. Security: These are REQUIRED.
    # Use 'credentials' to point to files containing the secrets to keep them out of the Nix store.
    # If you don't care about the Nix store being world-readable, move these to 'env' as strings.
    credentials = {
      CREDS_KEY = "/run/secrets/librechat_creds_key";
      CREDS_IV = "/run/secrets/librechat_creds_iv";
      JWT_SECRET = "/run/secrets/librechat_jwt_secret";
      JWT_REFRESH_SECRET = "/run/secrets/librechat_jwt_refresh";
    };

    # 3. Optional Search: Enable Meilisearch for chat history search
    meilisearch.enable = true;

    # 4. Endpoints and Settings
    settings = {
      version = "1.2.1";
      endpoints = {
        # Example: OpenAI Configuration
        openai = {
          apiKey = "\${API_KEY}"; # References an env var from credentials
        };
      };
    };

    # 5. API Keys: Add any keys your endpoints need here
    # Ensure the files exist at these paths and are readable by the 'librechat' user.
    credentials.API_KEY = "/run/secrets/deepseek_key";
  };

  # Mandatory if Meilisearch is enabled
  services.meilisearch.masterKeyFile = "/run/secrets/meili_master_key";
}
