<script setup lang="ts">
defineProps<{
  images: string[]
  alt: string
}>()

const activeIndex = ref(0)

function select(index: number) {
  activeIndex.value = index
}

function prev() {
  activeIndex.value = activeIndex.value === 0 ? images.length - 1 : activeIndex.value - 1
}

function next() {
  activeIndex.value = activeIndex.value === images.length - 1 ? 0 : activeIndex.value + 1
}
</script>

<template>
  <div class="space-y-4">
    <!-- Main image -->
    <div class="relative aspect-[4/5] overflow-hidden bg-linen">
      <img
        :src="images[activeIndex]"
        :alt="alt"
        class="h-full w-full object-cover transition-all duration-700"
      >

      <!-- Nav arrows -->
      <button
        class="absolute left-3 top-1/2 -translate-y-1/2 flex h-10 w-10 items-center justify-center rounded-full bg-rice/70 text-carbon/52 backdrop-blur-sm transition hover:bg-rice hover:text-carbon"
        @click="prev"
        aria-label="上一张"
      >
        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 19l-7-7 7-7" />
        </svg>
      </button>
      <button
        class="absolute right-3 top-1/2 -translate-y-1/2 flex h-10 w-10 items-center justify-center rounded-full bg-rice/70 text-carbon/52 backdrop-blur-sm transition hover:bg-rice hover:text-carbon"
        @click="next"
        aria-label="下一张"
      >
        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5l7 7-7 7" />
        </svg>
      </button>

      <!-- Counter -->
      <div class="absolute bottom-4 right-4 rounded-full bg-carbon/60 px-3 py-1 text-xs text-rice/80 backdrop-blur-sm">
        {{ activeIndex + 1 }} / {{ images.length }}
      </div>
    </div>

    <!-- Thumbnails -->
    <div class="flex gap-3" v-if="images.length > 1">
      <button
        v-for="(img, idx) in images"
        :key="idx"
        class="aspect-[4/5] w-20 flex-shrink-0 overflow-hidden border-2 transition duration-300"
        :class="idx === activeIndex ? 'border-clay' : 'border-transparent opacity-52 hover:opacity-82'"
        @click="select(idx)"
        :aria-label="`查看第 ${idx + 1} 张图片`"
      >
        <img
          :src="img"
          :alt="`${alt} 缩略图 ${idx + 1}`"
          class="h-full w-full object-cover"
        >
      </button>
    </div>
  </div>
</template>
