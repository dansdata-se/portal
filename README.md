# Dansdata.se Portal

An administration interface for managing API keys and data presented via the dansdata API.

## Getting Started

The administration portal is based on [next.js](https://nextjs.org/) and uses [supabase](https://supabase.com/)
as its backend.

First, start your local supabase backend:

```bash
# See https://supabase.com/docs/guides/local-development for instructions on
# setting up the supabase CLI
supabase start
```

Take note of the `API URL` and `anon key`. Add these to your local `.env.local` file at the repository root:

```dotenv
NEXT_PUBLIC_SUPABASE_URL=<your-supabase-api-url>
NEXT_PUBLIC_SUPABASE_ANON_KEY=<your-anon-key>
```

Finally, run the development server:

```bash
npm run dev
# or
yarn dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

### Supabase

The portal uses supabase as its backend. For more details on local development using
supabase during local development, please see the
[official guide](https://supabase.com/docs/guides/local-development).

### Storybook

Components are documented using [Storybook](https://storybook.js.org/).

You can view this documentation by running

```bash
npm run storybook
```

Stories should be located next to their respective components in a `[component].stories.mdx` file.
Note that `mdx` is the preferred format for this project, though `tsx` is also supported if `mdx` does not offer enough flexibility.

## About Dansdata.se

Dansdata (lit. "dance data") is an open API for information relating to social dancing in Sweden.

[Felix Zedén Yverås](https://github.com/FelixZY) is the project's current maintainer.

## License

MIT
