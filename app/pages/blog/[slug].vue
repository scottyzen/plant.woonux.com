<script setup lang="ts">
import type { GetPostQuery } from '#gql/default';

type BlogPost = NonNullable<GetPostQuery['post']>;

const route = useRoute();
const { siteName, siteImage } = useAppConfig();
const slug = computed(() => String(route.params.slug));
const { data, error } = await useAsyncGql('getPost', { slug: slug.value });
const post = computed<BlogPost | null>(() => data.value?.post ?? null);

if (!post.value && !error.value) {
  throw createError({ statusCode: 404, statusMessage: 'Article not found' });
}

const formatDate = (date?: string | null) =>
  date ? new Intl.DateTimeFormat('en', { day: 'numeric', month: 'long', year: 'numeric' }).format(new Date(date)) : '';

useSeoMeta({
  title: () => post.value?.title || 'Article',
  description: () => post.value?.excerpt?.replace(/<[^>]*>/g, '').trim() || `A story from ${siteName}.`,
  ogImage: () => post.value?.featuredImage?.node?.sourceUrl || siteImage,
  twitterCard: 'summary_large_image',
});
</script>

<template>
  <main class="bg-[#fffefb] text-[#1a3b22]">
    <article v-if="post">
      <header class="border-b border-[#e3eadc] bg-[#f2f7ec]">
        <div class="container max-w-4xl py-9 sm:py-12 lg:py-14">
          <a href="/blog" class="inline-flex items-center gap-2 text-sm font-bold text-[#286134] hover:text-[#d49f00]"><span aria-hidden="true">←</span> Back to journal</a>
          <p v-if="post.date" class="mt-7 text-xs font-bold uppercase tracking-[.16em] text-[#588354]">{{ formatDate(post.date) }}</p>
          <h1 class="mt-3 text-4xl leading-[1.04] tracking-[-.055em] sm:text-6xl">{{ post.title }}</h1>
        </div>
      </header>

      <div v-if="post.featuredImage?.node?.sourceUrl" class="container max-w-5xl pt-8 sm:pt-12">
        <NuxtImg :src="post.featuredImage.node.sourceUrl" :alt="post.featuredImage.node.altText || post.title || ''" width="1200" height="675" class="aspect-video w-full rounded-3xl object-cover" />
      </div>

      <div class="container max-w-3xl py-10 sm:py-14 lg:py-16">
        <div class="prose prose-lg max-w-none text-[#415843] prose-p:leading-8 prose-headings:mt-10 prose-headings:tracking-[-.035em] prose-a:font-bold prose-a:text-[#286134] prose-img:rounded-2xl" v-html="post.content" />
      </div>
    </article>

    <div v-else class="container py-16 text-center sm:py-20">
      <h1 class="text-3xl">We couldn't load this article.</h1>
      <a href="/blog" class="mt-5 inline-flex text-sm font-bold text-[#286134] hover:text-[#d49f00]">Back to journal</a>
    </div>
  </main>
</template>
