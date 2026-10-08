<script setup lang="ts">
import type { GetPostsQuery } from '#gql/default';

type PostPreview = NonNullable<NonNullable<GetPostsQuery['posts']>['nodes'][number]>;

const { siteName, siteImage } = useAppConfig();
const { data, error, status } = await useAsyncGql('getPosts');
const posts = computed<PostPreview[]>(() => data.value?.posts?.nodes ?? []);
const isLoading = computed(() => status.value === 'idle' || status.value === 'pending');

const formatDate = (date?: string | null) =>
  date ? new Intl.DateTimeFormat('en', { day: 'numeric', month: 'long', year: 'numeric' }).format(new Date(date)) : '';

useSeoMeta({
  title: 'Journal',
  description: `Plant care notes, fresh ideas, and news from ${siteName}.`,
  ogImage: siteImage,
  twitterCard: 'summary_large_image',
});
</script>

<template>
  <main class="bg-[#fffefb] pb-16 text-[#1a3b22] lg:pb-24">
    <section class="border-b border-[#e3eadc] bg-[#f2f7ec]">
      <div class="container py-14 sm:py-20">
        <p class="mb-3 text-xs font-bold uppercase tracking-[.16em] text-[#588354]">From the journal</p>
        <h1 class="max-w-2xl text-5xl tracking-[-.055em] sm:text-6xl">A little more green, every day.</h1>
        <p class="mt-5 max-w-xl text-base leading-7 text-[#546356]">Plant care notes, home inspiration, and stories from {{ siteName }}.</p>
      </div>
    </section>

    <section class="container py-10 sm:py-14 lg:py-16">
      <div v-if="isLoading" class="flex min-h-64 items-center justify-center"><LoadingIcon size="32" stroke="3" /></div>

      <div v-else-if="posts.length" class="grid grid-cols-[repeat(auto-fit,minmax(min(100%,21rem),1fr))] gap-5 lg:gap-7">
        <article
          v-for="post in posts"
          :key="post.id"
          class="group overflow-hidden rounded-3xl border border-[#e3eadc] bg-white shadow-sm transition hover:-translate-y-1 hover:shadow-lg hover:shadow-[#244423]/10">
          <NuxtLink :to="`/blog/${post.slug}`" external class="block">
            <div class="aspect-[16/9] bg-[#edf4e7]">
              <NuxtImg
                v-if="post.featuredImage?.node?.sourceUrl"
                :src="post.featuredImage.node.sourceUrl"
                :alt="post.featuredImage.node.altText || post.title || ''"
                width="800"
                height="450"
                class="size-full object-cover transition duration-300 group-hover:scale-[1.03]" />
              <div v-else class="flex size-full items-center justify-center text-[#588354]"><Icon name="ion:leaf-outline" size="42" /></div>
            </div>
          </NuxtLink>
          <div class="flex min-h-60 flex-col p-6 sm:p-7">
            <p v-if="post.date" class="text-xs font-bold uppercase tracking-[.14em] text-[#588354]">{{ formatDate(post.date) }}</p>
            <h2 class="mt-3 text-2xl leading-tight tracking-[-.035em]">
              <NuxtLink :to="`/blog/${post.slug}`" external class="hover:text-[#3d7b3d]">{{ post.title }}</NuxtLink>
            </h2>
            <div v-if="post.excerpt" class="prose prose-sm mt-4 max-w-none text-[#546356]" v-html="post.excerpt"></div>
            <NuxtLink
              :to="`/blog/${post.slug}`"
              external
              class="mt-auto inline-flex items-center gap-2 pt-5 text-sm font-bold text-[#286134] hover:text-[#d49f00]"
              >Read article <span aria-hidden="true">→</span></NuxtLink
            >
          </div>
        </article>
      </div>

      <div v-else class="rounded-3xl border border-dashed border-[#cddbc6] bg-white px-6 py-16 text-center">
        <Icon name="ion:leaf-outline" class="text-[#588354]" size="36" />
        <h2 class="mt-4 text-2xl">Nothing published yet.</h2>
        <p class="mx-auto mt-3 max-w-md leading-7 text-[#546356]">Publish a post in WordPress and it will appear here automatically.</p>
        <p v-if="error" class="mt-4 text-sm text-[#a24a2d]">We couldn't load journal entries right now. Please try again shortly.</p>
      </div>
    </section>
  </main>
</template>
