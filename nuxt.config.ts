export default defineNuxtConfig({
  compatibilityDate: '2026-06-03',
  modules: ['@nuxtjs/tailwindcss'],
  css: ['~/assets/css/tailwind.css'],
  devtools: { enabled: true },
  nitro: {
    externals: {
      trace: false
    }
  },
  app: {
    head: {
      title: '物志东方 | Contemporary Chinese Lifestyle',
      meta: [
        { name: 'description', content: '物志东方 is a contemporary Chinese lifestyle brand shaped by materiality, craftsmanship, silence, nature, ceramics, linen, incense, light and shadow.' },
        { name: 'color-scheme', content: 'light only' },
        { property: 'og:title', content: '物志东方' },
        { property: 'og:description', content: 'Contemporary Eastern living through ceramics, linen, incense, and quiet craft.' },
        { property: 'og:image', content: '/images/hero-still-life.png' }
      ]
    }
  }
})
