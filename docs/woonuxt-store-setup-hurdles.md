# WooNuxt store setup hurdles

This is a running record of issues encountered while setting up and maintaining
the Plantivo WooNuxt store. It is intended to preserve concrete symptoms,
workarounds, and upstream follow-ups so future stores do not have to rediscover
them. It is not a general WooNuxt installation guide.

Last checked: 2026-10-06  
WooNuxt source checked: `scottyzen/woonuxt` commit `7b58fed`

## Confirmed hurdles

### Keeping the WooNuxt base layer up to date

**Observed:** This storefront tracks `woonuxt_base/` as ordinary files in the
store repository. There is no separate upstream remote or pinned base version,
so importing an upstream update changes many individual files in the store's
working tree. Locally customized base files then need to be compared and
merged by hand.

**Example:** The product gallery had a local aspect-ratio fix, and the local
GraphQL image fragments had been consolidated around a shared `Image` fragment.
Both areas overlapped with the upstream image fix when syncing. The local
behavior was preserved while taking the remaining upstream changes.

**Current workaround:** Fetch `scottyzen/woonuxt` and selectively apply its
`woonuxt_base/` changes. Compare any locally modified files before updating;
keep storefront-specific pages, components, assets, and configuration in the
root child layer where practical.

**Upstream follow-up:** Provide a clear, supported way to consume and update
the shared WooNuxt layer while keeping store overrides separate. The public
npm registry currently returns 404 for `woonuxt@4.28.2`, so a package-based
update is not currently available there.

### Product galleries need image dimensions from GraphQL

**Observed:** Product images can have different aspect ratios. The gallery
needs the image's actual width and height to reserve the correct space and
avoid treating every image as square.

**Store-side fix:** Request `mediaDetails { width height }` through the shared
`Image` GraphQL fragment, use those dimensions for the main gallery image, and
keep `object-contain` on the main image. Thumbnails can use `object-cover`.

**Upstream status:** These fields and aspect-ratio-based sizing are present in
the WooNuxt source checked above. When updating older stores, confirm both the
query fields and the component implementation are included.

### Type-checking currently exposes upstream integration errors

**Observed:** After syncing the WooNuxt source checked above, `npm run
typecheck` completed GraphQL code generation but failed on:

- `gql:auth:init` not being recognized as a Nuxt hook in
  `woonuxt_base/app/composables/gql.ts` and
  `woonuxt_base/app/plugins/gql-auth.ts`; the plugin callback's `token`
  parameter was also implicitly `any`.
- A Stripe plugin call passing `{}` where a `string` is expected.

**Caveat:** These errors were observed against this store and its generated
types; they have not been independently reproduced in a clean WooNuxt checkout.
Re-run type-checking against a clean checkout and current GraphQL schema before
treating them as confirmed regressions for all stores.

**Useful command:** `npm run typecheck` runs GraphQL code generation first, so
it requires a reachable `GQL_HOST` configured in the root `.env`.

## Recording future hurdles

When adding a hurdle, record the exact symptom, the command or user action that
revealed it, the relevant WooNuxt revision and store configuration (excluding
secrets), the workaround or fix, and whether it was reproduced in a clean
WooNuxt project. Keep store-specific branding and custom behavior distinct
from fixes that belong in WooNuxt itself.
