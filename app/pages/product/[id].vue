<script setup lang="ts">
import { getProductById, getRelatedProducts } from '~/data/products'
import type { SkuVariant } from '~/types/product'

const route = useRoute()
const id = computed(() => route.params.id as string)

const product = computed(() => getProductById(id.value))
const related = computed(() => product.value ? getRelatedProducts(product.value.relatedIds) : [])

const skuRef = ref<InstanceType<typeof ProductSkuSelector> | null>(null)
const activeSku = ref<SkuVariant | null>(null)

function onSkuSelect(sku: SkuVariant) {
  activeSku.value = sku
}

function handleBuy() {
  if (!activeSku.value) return
  if (!activeSku.value.stock) return
  // Placeholder: 后期可对接购物车/下单流程
  alert(`已选择: ${activeSku.value.sku} — ${activeSku.value.price}`)
}

// 404 handling
if (!product.value) {
  throw createError({ statusCode: 404, statusMessage: '商品未找到' })
}
</script>

<template>
  <div v-if="product" class="min-h-screen bg-rice text-carbon">
    <!-- Nav -->
    <header class="fixed inset-x-0 top-0 z-50 border-b border-carbon/10 bg-rice/82 backdrop-blur-xl">
      <nav class="mx-auto flex h-16 max-w-7xl items-center justify-between px-5 sm:px-8 lg:px-12">
        <NuxtLink to="/#products" class="flex items-center gap-2 text-sm text-carbon/52 transition hover:text-clay">
          <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
          </svg>
          返回
        </NuxtLink>
        <NuxtLink to="/" class="font-editorial text-xl text-ink sm:text-2xl">物志东方</NuxtLink>
        <div class="w-16" />
      </nav>
    </header>

    <main class="mx-auto max-w-7xl px-5 pt-24 pb-20 sm:px-8 lg:px-12">
      <!-- Breadcrumb -->
      <nav class="mb-8 flex items-center gap-2 text-sm text-carbon/44">
        <NuxtLink to="/" class="transition hover:text-clay">首页</NuxtLink>
        <span>/</span>
        <NuxtLink to="/#products" class="transition hover:text-clay">本季器物</NuxtLink>
        <span>/</span>
        <span class="text-carbon/72">{{ product.name }}</span>
      </nav>

      <!-- Product layout: gallery + info -->
      <div class="grid gap-10 lg:grid-cols-[1.18fr_0.82fr] lg:gap-16">
        <!-- LEFT: Gallery -->
        <div v-motion-reveal>
          <ProductImageGallery
            :images="product.images"
            :alt="product.name"
          />
        </div>

        <!-- RIGHT: Product Info -->
        <div v-motion-reveal class="motion-delay-1">
          <!-- Meta -->
          <p class="mb-2 text-sm text-carbon/52">{{ product.type }}</p>
          <h1 class="font-editorial text-4xl leading-tight text-ink sm:text-5xl">{{ product.name }}</h1>

          <!-- Description -->
          <p class="mt-6 leading-8 text-carbon/66">{{ product.description }}</p>

          <!-- Details list -->
          <ul class="mt-8 space-y-3 border-t border-carbon/12 pt-8">
            <li
              v-for="(detail, idx) in product.details"
              :key="idx"
              class="flex items-start gap-3 text-sm leading-6 text-carbon/60"
            >
              <span class="mt-1.5 h-1 w-1 flex-shrink-0 rounded-full bg-clay/44" />
              {{ detail }}
            </li>
          </ul>

          <!-- Specs -->
          <div class="mt-8 space-y-4 border-t border-carbon/12 pt-8">
            <div class="grid grid-cols-[5.5rem_1fr] gap-x-4 gap-y-3 text-sm">
              <span class="text-carbon/44">材质</span>
              <span class="text-carbon/72">{{ product.materials }}</span>
              <span class="text-carbon/44">尺寸</span>
              <span class="text-carbon/72">{{ product.dimensions }}</span>
              <span class="text-carbon/44">养护</span>
              <span class="text-carbon/72">{{ product.care }}</span>
            </div>
          </div>

          <!-- SKU Selector -->
          <ProductSkuSelector
            ref="skuRef"
            :sku-options="product.skuOptions"
            :sku-variants="product.skuVariants"
            @select="onSkuSelect"
          />

          <!-- Buy button -->
          <button
            class="mt-8 w-full border border-carbon/30 px-8 py-4 text-sm tracking-wider transition duration-300"
            :class="activeSku && activeSku.stock ? 'border-carbon bg-carbon text-rice hover:bg-ink' : 'border-carbon/14 text-carbon/22 cursor-not-allowed'"
            :disabled="!activeSku || !activeSku.stock"
            @click="handleBuy"
          >
            {{ activeSku ? (activeSku.stock ? '加入品鉴清单' : '暂时缺货') : '请选择规格' }}
          </button>
        </div>
      </div>

      <!-- Related products -->
      <section v-if="related.length > 0" v-motion-reveal class="mt-24 border-t border-carbon/12 pt-16">
        <h2 class="font-editorial text-3xl leading-tight text-ink sm:text-4xl">相关器物</h2>
        <div class="mt-10 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          <NuxtLink
            v-for="item in related"
            :key="item.id"
            :to="`/product/${item.id}`"
            class="group border border-carbon/10 bg-rice transition hover:shadow-soft"
          >
            <div class="aspect-[4/5] overflow-hidden bg-paper">
              <img
                :src="item.images[0]"
                :alt="item.name"
                class="h-full w-full object-cover transition duration-700 group-hover:scale-105"
              >
            </div>
            <div class="p-5">
              <p class="text-sm text-carbon/52">{{ item.type }}</p>
              <div class="mt-2 flex items-start justify-between gap-4">
                <h3 class="font-editorial text-xl leading-tight text-ink">{{ item.name }}</h3>
                <span class="text-sm text-clay">{{ item.price }}</span>
              </div>
            </div>
          </NuxtLink>
        </div>
      </section>
    </main>

    <!-- Footer -->
    <footer class="bg-carbon px-5 py-14 text-rice sm:px-8 lg:px-12">
      <div class="mx-auto max-w-7xl">
        <NuxtLink to="/" class="font-editorial text-5xl leading-none">物志东方</NuxtLink>
      </div>
    </footer>
  </div>
</template>
