# Dansdata.se Portal

An administration interface for managing API keys and data presented via the dansdata API.

## Getting Started

The project utilizes a [devcontainer](https://code.visualstudio.com/docs/remote/containers)
with most dependencies, including `supabase-cli`, already included.

`npm` is used to assist with some scripts and tools. See the `scripts` section of
[`package.json`](./package.json) for information. Make sure to run `npm i` on first setup to install
required packages and shared git hooks.

The administration portal is based on [Flutter](https://flutter.dev/) and uses
[supabase](https://supabase.com/) as its backend.

To start your local supabase backend:

```bash
supabase start
```

To run the development server, use the "Run and Debug" menu in VSCode (recommended), or

```bash
npm start
```

To generate database documentation (requires supabase to be running)

```bash
npm run docs
```

To run code generation, use the "Code generator" VSCode task (from
[`tasks.json`](./.vscode/tasks.json)), or

```bash
npm run gen
```

### Supabase

The portal uses supabase as its backend. For more details on local development using
supabase, please see the [official guide](https://supabase.com/docs/guides/local-development).

#### SSO

By default, SSO is disabled for local development builds. To enable SSO for your local environment,
you need to do 2 things:

1. Enable the SSO providers(s) of your choice in [`config.toml`](./supabase/config.toml):

```toml
[auth.external.<provider>]
enabled = true  # Add this line
client_id = "env(SSO_<PROVIDER>_CLIENT_ID)"
secret = "env(SSO_<PROVIDER>_SECRET)"
```

2. Ensure the relevant `SSO_<PROVIDER>_CLIENT_ID` and `SSO_<PROVIDER>_SECRET` variables are
   available when running `supabase start`.

When using the devcontainer, this can easily be done by adding the necessary variables to a local
[`.env`](./.env) file and rebuilding the container:

```dotenv
# ------------------------------------------------
# SSO (Single Sign On)
# ------------------------------------------------
#
# Note!
# You will need to rebuild the devcontainer and
# restart your local supabase environment to
# apply any changes to `.env`!

# See https://supabase.com/docs/guides/auth/auth-facebook
SSO_FACEBOOK_SECRET=abc123
SSO_FACEBOOK_CLIENT_ID=abc123

# See https://supabase.com/docs/guides/auth/auth-github
SSO_GITHUB_SECRET=abc123
SSO_GITHUB_CLIENT_ID=abc123

# See https://supabase.com/docs/guides/auth/auth-google
SSO_GOOGLE_SECRET=abc123
SSO_GOOGLE_CLIENT_ID=abc123
```

Note that you will need to generate your own `CLIENT_ID` and `SECRET` for local testing!
See https://supabase.com/docs/guides/auth for more info.

## About Dansdata.se

Dansdata (lit. "dance data") is an open API for information relating to social dancing in Sweden.

[Felix Zedén Yverås](https://github.com/FelixZY) is the project's current maintainer.

## License

MIT

<p xmlns:cc="http://creativecommons.org/ns#">Images by <span property="cc:attributionName">dansdata.se and contributors</span> are licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" /><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" /><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1" /></a></p>
