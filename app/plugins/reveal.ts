export default defineNuxtPlugin((nuxtApp) => {
  if (import.meta.client) {
    document.documentElement.classList.add('motion-enabled')
  }

  nuxtApp.vueApp.directive('motion-reveal', {
    getSSRProps() {
      return {
        class: 'motion-ready'
      }
    },
    mounted(el: HTMLElement) {
      const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches

      el.classList.add('motion-ready')

      if (reducedMotion) {
        el.classList.add('is-visible')
        return
      }

      const observer = new IntersectionObserver(
        ([entry]) => {
          if (!entry?.isIntersecting) {
            return
          }

          el.classList.add('is-visible')
          observer.unobserve(el)
        },
        {
          threshold: 0.16,
          rootMargin: '0px 0px -8% 0px'
        }
      )

      observer.observe(el)
    }
  })
})
