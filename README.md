# Dansdata.se Portal

An administration interface for managing API keys and data presented via the dansdata API.

## Getting Started

The project utilizes a [devcontainer](https://code.visualstudio.com/docs/remote/containers)
with most dependencies, including `supabase-cli`, already included.

Note that VSCode likes to perform automatic port forwarding when opening links, which can sometimes
cause issues when viewing storybook. If storybook opens with some content not loading properly,
try checking if VSCode opened storybook on port e.g. `6007` despite running on `6006` as a first
measure.

The administration portal is based on [next.js](https://nextjs.org/) and uses [supabase](https://supabase.com/)
as its backend.

To start your local supabase backend:

```bash
supabase start
```

To run the development server:

```bash
npm run dev
```

To generate database documentation (requires supabase to be running)

```bash
npm run docs
```

### Supabase

The portal uses supabase as its backend. For more details on local development using
supabase, please see the [official guide](https://supabase.com/docs/guides/local-development).

### Storybook

Components are documented using [Storybook](https://storybook.js.org/).

You can view this documentation by running

```bash
npm run storybook
```

Stories should be located next to their respective components in a `[component].stories.(mdx|tsx)` file.

## About Dansdata.se

Dansdata (lit. "dance data") is an open API for information relating to social dancing in Sweden.

[Felix Zedén Yverås](https://github.com/FelixZY) is the project's current maintainer.

## License

MIT

<p xmlns:cc="http://creativecommons.org/ns#">Images by <span property="cc:attributionName">dansdata.se and contributors</span> are licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" /><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" /><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1" /></a></p>
