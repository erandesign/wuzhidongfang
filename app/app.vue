<script setup lang="ts">
useHead({
  htmlAttrs: {
    lang: 'zh-CN'
  }
})

const navItems = [
  { label: '理念', href: '#manifesto' },
  { label: '器物', href: '#categories' },
  { label: '札记', href: '#journal' }
]

const categories = [
  {
    title: '陶瓷',
    latin: 'Ceramics',
    image: '/images/category-ceramics.png',
    copy: '低温釉色、手修口沿与含蓄比例，留住泥土被火安静改变的一刻。'
  },
  {
    title: '亚麻',
    latin: 'Linen',
    image: '/images/category-linen.png',
    copy: '天然纤维经过水洗、日晒与慢织，成为餐桌、卧榻与行旅中的柔软秩序。'
  },
  {
    title: '香器',
    latin: 'Incense',
    image: '/images/category-incense.png',
    copy: '木、陶、石之间的微小尺度，让气息缓慢升起，也让空间重新有了停顿。'
  },
  {
    title: '光影',
    latin: 'Light',
    image: '/images/category-light.png',
    copy: '纸、竹、石与暖光的层次，适合黄昏、雨日与一间足够安静的屋子。'
  }
]

const products = [
  {
    name: '月白敛口瓶',
    type: '手作陶瓷',
    price: '¥1,280',
    image: '/images/product-vessel.png'
  },
  {
    name: '素麻长巾',
    type: '水洗亚麻',
    price: '¥620',
    image: '/images/product-linen-runner.png'
  },
  {
    name: '玄石卧香座',
    type: '石陶复合',
    price: '¥760',
    image: '/images/product-incense-holder.png'
  },
  {
    name: '纸影夜灯',
    type: '楮纸与胡桃木',
    price: '¥1,460',
    image: '/images/product-stone-lamp.png'
  }
]

const journals = [
  {
    title: '器物的静默不是空白',
    category: 'Craft',
    image: '/images/journal-ceramic.png',
    excerpt: '一次烧成之后，釉面留下的细小呼吸，往往比装饰更接近东方的尺度。'
  },
  {
    title: '一块布的四季',
    category: 'Material',
    image: '/images/journal-linen.png',
    excerpt: '亚麻会记录日常：清晨的折痕、午后的温度、夜晚被收起时的微光。'
  },
  {
    title: '黄昏里的香',
    category: 'Ritual',
    image: '/images/journal-incense.png',
    excerpt: '气味不是装饰，它更像一个缓慢的界面，让房间从忙碌中退后半步。'
  }
]
</script>

<template>
  <div class="min-h-screen overflow-hidden bg-rice text-carbon">
    <header class="fixed inset-x-0 top-0 z-50 border-b border-carbon/10 bg-rice/82 backdrop-blur-xl">
      <nav class="mx-auto flex h-16 max-w-7xl items-center justify-between px-5 sm:px-8 lg:px-12" aria-label="Primary navigation">
        <a href="#hero" class="font-editorial text-xl text-ink sm:text-2xl">物志东方</a>
        <div class="hidden items-center gap-8 text-sm text-carbon/72 sm:flex">
          <a
            v-for="item in navItems"
            :key="item.href"
            :href="item.href"
            class="transition hover:text-clay"
          >
            {{ item.label }}
          </a>
        </div>
        <a
          href="#products"
          class="border border-carbon/30 px-4 py-2 text-sm transition hover:border-clay hover:bg-clay hover:text-rice"
        >
          品鉴
        </a>
      </nav>
    </header>

    <main>
      <section id="hero" class="relative isolate flex min-h-[92svh] overflow-hidden bg-carbon text-rice">
        <div class="absolute inset-0 -z-10">
          <img
            src="/images/hero-still-life.png"
            alt="Ceramic vessel, linen, incense, and warm shadow arranged as a quiet Eastern still life"
            class="hero-image h-full w-full object-cover object-center"
          >
          <div class="absolute inset-0 bg-[linear-gradient(90deg,rgba(25,25,22,0.82),rgba(25,25,22,0.38)_48%,rgba(25,25,22,0.08))]" />
          <div class="absolute inset-x-0 bottom-0 h-32 bg-gradient-to-t from-rice via-rice/14 to-transparent" />
        </div>

        <div class="mx-auto flex w-full max-w-7xl flex-col justify-end px-5 pb-16 pt-32 sm:px-8 lg:px-12">
          <div v-motion-reveal class="max-w-3xl">
            <p class="mb-5 text-sm uppercase text-rice/72">Contemporary Eastern Living</p>
            <h1 class="font-editorial text-6xl leading-[0.98] text-rice sm:text-7xl md:text-8xl">
              物志东方
            </h1>
            <p class="mt-7 max-w-xl text-base leading-8 text-rice/78 sm:text-lg">
              以器物记录东方生活的当代轮廓。陶、麻、香与光影，在沉静的日常里成为可触摸的时间。
            </p>
          </div>

          <div v-motion-reveal class="motion-delay-1 mt-16 grid gap-5 border-t border-rice/22 pt-6 text-sm text-rice/72 sm:grid-cols-3">
            <span>Materiality / Craftsmanship</span>
            <span>Silence / Nature</span>
            <span>Hangzhou / Spring Summer 2026</span>
          </div>
        </div>
      </section>

      <section id="manifesto" class="bg-rice px-5 py-20 sm:px-8 sm:py-28 lg:px-12">
        <div class="mx-auto grid max-w-7xl gap-12 lg:grid-cols-[0.82fr_1.18fr] lg:gap-20">
          <div v-motion-reveal>
            <p class="mb-5 text-sm text-clay">Brand Manifesto</p>
            <h2 class="font-editorial text-4xl leading-tight text-ink sm:text-5xl">
              不以繁复表明价值，<br class="hidden sm:block">
              只让材料自己发声。
            </h2>
          </div>
          <div v-motion-reveal class="motion-delay-1 space-y-8 text-lg leading-9 text-carbon/72">
            <p>
              物志东方相信，生活的美并不总在显眼处。它可以是一只杯口的薄度，一块亚麻经纬里的光，一缕香在屋檐下转弯的速度。
            </p>
            <p>
              我们从传统东方审美中取其克制、留白与自然感，再以当代的尺度重新塑形。器物不喧哗，也不回避功能；它们只是安稳地放在生活中，等待被使用、被触摸、被记住。
            </p>
          </div>
        </div>
      </section>

      <section id="categories" class="bg-paper px-5 py-20 sm:px-8 sm:py-28 lg:px-12">
        <div class="mx-auto max-w-7xl">
          <div v-motion-reveal class="mb-12 flex flex-col justify-between gap-6 border-t border-carbon/16 pt-8 md:flex-row md:items-end">
            <div>
              <p class="mb-4 text-sm text-rust">Product Categories</p>
              <h2 class="font-editorial text-4xl leading-tight text-ink sm:text-5xl">四类日用，归于一室安静。</h2>
            </div>
            <p class="max-w-md leading-8 text-carbon/66">
              每一件器物都从手感开始：粗细、重量、温度、光泽，先被身体理解，再被空间接纳。
            </p>
          </div>

          <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
            <article
              v-for="(category, index) in categories"
              :key="category.title"
              v-motion-reveal
              :class="index > 0 ? 'motion-delay-1' : ''"
              class="group bg-rice"
            >
              <div class="aspect-[4/5] overflow-hidden">
                <img
                  :src="category.image"
                  :alt="`${category.title} product category still life`"
                  class="h-full w-full object-cover transition duration-700 group-hover:scale-105"
                >
              </div>
              <div class="border border-t-0 border-carbon/10 p-6">
                <div class="flex items-baseline justify-between gap-4">
                  <h3 class="font-editorial text-3xl text-ink">{{ category.title }}</h3>
                  <span class="text-sm text-carbon/52">{{ category.latin }}</span>
                </div>
                <p class="mt-5 min-h-24 leading-7 text-carbon/66">{{ category.copy }}</p>
              </div>
            </article>
          </div>
        </div>
      </section>

      <section id="stories" class="bg-rice px-5 py-20 sm:px-8 sm:py-28 lg:px-12">
        <div class="mx-auto grid max-w-7xl gap-10 lg:grid-cols-[0.92fr_1.08fr] lg:items-end lg:gap-16">
          <div v-motion-reveal class="order-2 lg:order-1">
            <img
              src="/images/lifestyle-room.png"
              alt="Quiet interior with linen, ceramics, incense, and angled afternoon light"
              class="aspect-[5/4] w-full object-cover shadow-soft"
            >
          </div>
          <div v-motion-reveal class="motion-delay-1 order-1 lg:order-2">
            <p class="mb-5 text-sm text-moss">Lifestyle Storytelling</p>
            <h2 class="font-editorial text-4xl leading-tight text-ink sm:text-5xl">
              房间有风，器物有呼吸，日常便慢了下来。
            </h2>
            <div class="mt-9 grid gap-8 border-t border-carbon/14 pt-8 sm:grid-cols-2">
              <p class="leading-8 text-carbon/68">
                清晨，水汽从陶杯边缘散开；午后，亚麻桌旗把影子切得更轻；入夜，香气在纸灯旁收束成一处安静。
              </p>
              <p class="leading-8 text-carbon/68">
                物志东方不追逐季节的热闹，而是把自然、手工与光的变化留在生活内部，让家成为可被缓慢阅读的空间。
              </p>
            </div>
          </div>
        </div>
      </section>

      <section id="products" class="hairline-grid bg-ash/24 px-5 py-20 sm:px-8 sm:py-28 lg:px-12">
        <div class="mx-auto max-w-7xl">
          <div v-motion-reveal class="mb-12 grid gap-6 md:grid-cols-[0.8fr_1.2fr] md:items-end">
            <div>
              <p class="mb-4 text-sm text-clay">Featured Products</p>
              <h2 class="font-editorial text-4xl leading-tight text-ink sm:text-5xl">本季器物</h2>
            </div>
            <p class="max-w-2xl leading-8 text-carbon/66 md:justify-self-end">
              从泥、石、纸、麻之间挑选出克制而耐看的几件。适合独处，也适合被放进更长久的生活秩序中。
            </p>
          </div>

          <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            <article
              v-for="(product, index) in products"
              :key="product.name"
              v-motion-reveal
              :class="index % 2 === 1 ? 'motion-delay-1' : ''"
              class="group border border-carbon/10 bg-rice"
            >
              <div class="aspect-[4/5] overflow-hidden bg-paper">
                <img
                  :src="product.image"
                  :alt="product.name"
                  class="h-full w-full object-cover transition duration-700 group-hover:scale-105"
                >
              </div>
              <div class="p-5">
                <p class="text-sm text-carbon/52">{{ product.type }}</p>
                <div class="mt-3 flex items-start justify-between gap-4">
                  <h3 class="font-editorial text-2xl leading-tight text-ink">{{ product.name }}</h3>
                  <span class="text-sm text-clay">{{ product.price }}</span>
                </div>
              </div>
            </article>
          </div>
        </div>
      </section>

      <section id="journal" class="bg-rice px-5 py-20 sm:px-8 sm:py-28 lg:px-12">
        <div class="mx-auto max-w-7xl">
          <div v-motion-reveal class="mb-12 border-t border-carbon/16 pt-8">
            <p class="mb-4 text-sm text-moss">Journal</p>
            <h2 class="font-editorial text-4xl leading-tight text-ink sm:text-5xl">关于材料、季节与东方日常的札记。</h2>
          </div>

          <div class="grid gap-8 lg:grid-cols-3">
            <article
              v-for="(entry, index) in journals"
              :key="entry.title"
              v-motion-reveal
              :class="index > 0 ? 'motion-delay-1' : ''"
              class="group border-t border-carbon/18 pt-6"
            >
              <img
                :src="entry.image"
                :alt="entry.title"
                class="aspect-[16/11] w-full object-cover transition duration-700 group-hover:brightness-95"
              >
              <p class="mt-6 text-sm text-clay">{{ entry.category }}</p>
              <h3 class="mt-3 font-editorial text-3xl leading-tight text-ink">{{ entry.title }}</h3>
              <p class="mt-5 leading-8 text-carbon/66">{{ entry.excerpt }}</p>
            </article>
          </div>
        </div>
      </section>
    </main>

    <footer class="bg-carbon px-5 py-14 text-rice sm:px-8 lg:px-12">
      <div class="mx-auto grid max-w-7xl gap-10 md:grid-cols-[1.1fr_0.9fr] md:items-end">
        <div>
          <h2 class="font-editorial text-5xl leading-none">物志东方</h2>
          <p class="mt-6 max-w-lg leading-8 text-rice/64">
            Contemporary Chinese lifestyle objects shaped by craft, silence, nature, and light.
          </p>
        </div>
        <div class="grid gap-6 text-sm text-rice/64 sm:grid-cols-3 md:text-right">
          <div>
            <p class="text-rice">Studio</p>
            <p class="mt-2">Hangzhou</p>
          </div>
          <div>
            <p class="text-rice">Contact</p>
            <p class="mt-2">studio@wuzhidongfang.cn</p>
          </div>
          <div>
            <p class="text-rice">Year</p>
            <p class="mt-2">2026</p>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>
