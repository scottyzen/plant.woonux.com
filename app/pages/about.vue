<script setup lang="ts">
const { siteName, shortDescription, siteImage } = useAppConfig();

useSeoMeta({
  title: 'About',
  description: `${shortDescription} Meet ${siteName}, a demo storefront showing how WooNuxt can be shaped into a distinct online shop.`,
  ogTitle: `About ${siteName}`,
  ogDescription: shortDescription,
  ogImage: siteImage,
  twitterCard: 'summary_large_image',
});
</script>

<template>
  <main class="overflow-hidden bg-[#fffefb] text-[#1a3b22]">
    <section class="container grid items-center gap-10 py-14 lg:grid-cols-2 lg:gap-16 lg:py-24">
      <div class="max-w-xl">
        <p class="mb-5 flex items-center gap-2 text-xs font-bold uppercase tracking-[.16em] text-[#588354]">
          <span class="size-2 rounded-full bg-[#6b9d58]"></span>
          A WooNuxt demo storefront
        </p>
        <h1 class="text-5xl leading-[1.02] tracking-[-.055em] sm:text-6xl lg:text-7xl">
          A little more green.<br />A lot more <span class="text-[#5b984d]">you.</span>
        </h1>
        <p class="mt-6 max-w-lg text-base leading-7 text-[#546356]">
          {{ siteName }} is a sample plant shop built to show how WooNuxt can become a storefront with its own look, voice, and shopping experience. The plants
          and story are demo content; the catalog and commerce experience are powered by WooCommerce.
        </p>
        <div class="mt-8 flex flex-wrap gap-3">
          <NuxtLink
            to="/products"
            class="inline-flex items-center gap-5 rounded-full bg-[#3d7b3d] px-6 py-3.5 text-sm font-bold text-white transition hover:bg-[#286134]">
            Browse the plants <span class="text-xl" aria-hidden="true">→</span>
          </NuxtLink>
          <NuxtLink
            to="/categories"
            class="inline-flex items-center gap-2 rounded-full border border-[#dbe4d5] px-6 py-3.5 text-sm font-bold transition hover:border-[#3d7b3d]">
            Explore collections
          </NuxtLink>
        </div>
      </div>

      <div class="relative min-h-80 overflow-hidden rounded-[2rem] bg-[#f2f7ec] sm:min-h-105 lg:min-h-120">
        <NuxtImg
          src="/images/plant-hero.png"
          width="1672"
          height="941"
          :alt="`${siteName} demo: a leafy houseplant in a bright home`"
          class="absolute inset-0 size-full object-cover mix-blend-multiply" />
        <div class="absolute bottom-5 left-5 max-w-xs rounded-2xl bg-white/95 p-5 shadow-xl shadow-[#244423]/10 sm:bottom-8 sm:left-8">
          <span class="mb-2 block text-xs font-bold uppercase tracking-wide text-[#588354]">Your store, your style</span>
          <p class="text-lg leading-snug">A flexible WooCommerce foundation, dressed for Plantivo.</p>
        </div>
      </div>
    </section>

    <section class="container pb-16 lg:pb-24">
      <div class="rounded-3xl bg-[#0d5134] px-6 py-8 text-white sm:px-10 sm:py-10">
        <div class="grid gap-8 md:grid-cols-[.8fr_1.2fr] md:items-center">
          <div>
            <p class="mb-3 text-xs font-bold uppercase tracking-[.16em] text-[#c8e1a5]">More than a starter theme</p>
            <h2 class="text-3xl leading-tight tracking-[-.04em] sm:text-4xl">A starting point that feels like your brand.</h2>
          </div>
          <p class="max-w-2xl leading-7 text-white/75">
            WooNuxt provides the storefront foundation. Plantivo layers on its own colors, typography, page layouts, navigation, and product presentation—while
            WooCommerce remains the source for the catalog and commerce data. Change the layer, not the way your store works.
          </p>
        </div>
      </div>
    </section>

    <section class="container pb-16 lg:pb-24">
      <div class="mb-8 max-w-2xl">
        <p class="mb-2 text-xs font-bold uppercase tracking-[.16em] text-[#588354]">Made to be customized</p>
        <h2 class="text-3xl tracking-[-.045em] sm:text-4xl">Make the experience your own.</h2>
        <p class="mt-4 leading-7 text-[#546356]">A few examples of what a store can shape around its products and customers:</p>
      </div>

      <div class="grid gap-4 md:grid-cols-3">
        <article class="rounded-2xl border border-[#e3eadc] bg-white p-6">
          <span class="mb-5 inline-flex size-11 items-center justify-center rounded-full bg-[#edf4e7] text-[#286134]">
            <Icon name="ion:color-palette-outline" size="23" />
          </span>
          <h3 class="text-xl">Brand and visual style</h3>
          <p class="mt-3 text-sm leading-6 text-[#546356]">Set the palette, typography, logo, and details that make a storefront feel unmistakably yours.</p>
        </article>
        <article class="rounded-2xl border border-[#e3eadc] bg-white p-6">
          <span class="mb-5 inline-flex size-11 items-center justify-center rounded-full bg-[#edf4e7] text-[#286134]">
            <Icon name="ion:layers-outline" size="23" />
          </span>
          <h3 class="text-xl">Pages and storytelling</h3>
          <p class="mt-3 text-sm leading-6 text-[#546356]">
            Build custom landing and About pages, feature collections, and tell the story behind what you sell.
          </p>
        </article>
        <article class="rounded-2xl border border-[#e3eadc] bg-white p-6">
          <span class="mb-5 inline-flex size-11 items-center justify-center rounded-full bg-[#edf4e7] text-[#286134]">
            <Icon name="ion:bag-handle-outline" size="23" />
          </span>
          <h3 class="text-xl">A useful shopping flow</h3>
          <p class="mt-3 text-sm leading-6 text-[#546356]">Present products, categories, and useful shop features in a way that fits the people you serve.</p>
        </article>
      </div>
    </section>

    <section class="container pb-20 lg:pb-28">
      <div class="flex flex-col justify-between gap-6 rounded-3xl bg-[#f2f7ec] p-7 sm:p-10 md:flex-row md:items-center">
        <div class="max-w-2xl">
          <p class="mb-2 text-xs font-bold uppercase tracking-[.16em] text-[#588354]">A note about this demo</p>
          <h2 class="text-2xl tracking-[-.04em] sm:text-3xl">The story is sample content. The storefront is real.</h2>
          <p class="mt-3 leading-7 text-[#546356]">
            Use the shop and collection pages to explore the experience. Replace the sample branding and content with your own when you make it yours.
          </p>
        </div>
        <NuxtLink
          to="/products"
          class="inline-flex shrink-0 items-center justify-center gap-5 rounded-full bg-[#3d7b3d] px-6 py-3.5 text-sm font-bold text-white transition hover:bg-[#286134]">
          Explore the shop <span class="text-xl" aria-hidden="true">→</span>
        </NuxtLink>
      </div>
    </section>
  </main>
</template>
