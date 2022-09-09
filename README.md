# Dansdata.se Portal

An administration interface for managing API keys and data presented via the dansdata API.

## Getting Started

The project utilizes a [devcontainer](https://code.visualstudio.com/docs/remote/containers)
with most dependencies, including `supabase-cli`, already included.

The administration portal is based on [next.js](https://nextjs.org/) and uses [supabase](https://supabase.com/)
as its backend.

To start your local supabase backend:

```bash
supabase start
```

To run the development server:

```bash
npm run dev
# or
yarn dev
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
