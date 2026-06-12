<script setup lang="ts">
import type { SkuOption, SkuVariant } from '~/types/product'

const props = defineProps<{
  skuOptions: SkuOption[]
  skuVariants: SkuVariant[]
}>()

const emit = defineEmits<{
  (e: 'select', sku: SkuVariant): void
}>()

const selected = ref<Record<string, string>>({})

const currentVariant = computed(() => {
  const keys = Object.keys(selected.value)
  if (keys.length === 0) return null
  return props.skuVariants.find(v =>
    keys.every(k => v.options[k] === selected.value[k])
  ) ?? null
})

const currentPrice = computed(() => currentVariant.value?.price ?? null)
const inStock = computed(() => currentVariant.value?.stock ?? false)

function selectOption(label: string, value: string) {
  selected.value = { ...selected.value, [label]: value }
  if (currentVariant.value) {
    emit('select', currentVariant.value)
  }
}

function isOptionAvailable(label: string, value: string): boolean {
  const others = { ...selected.value }
  delete others[label]
  const keys = Object.keys(others)
  return props.skuVariants.some(v =>
    keys.every(k => v.options[k] === others[k]) &&
    v.options[label] === value
  )
}

defineExpose({ currentVariant, currentPrice, inStock })
</script>

<template>
  <div class="space-y-6 border-t border-carbon/12 pt-6">
    <div v-for="opt in skuOptions" :key="opt.label">
      <p class="mb-3 text-sm text-carbon/52">{{ opt.label }}</p>
      <div class="flex flex-wrap gap-3">
        <button
          v-for="val in opt.values"
          :key="val"
          class="min-w-[60px] border px-5 py-2 text-sm transition duration-300"
          :class="[
            selected[opt.label] === val
              ? 'border-clay bg-clay text-rice'
              : isOptionAvailable(opt.label, val)
                ? 'border-carbon/22 text-carbon/72 hover:border-carbon/44 hover:text-carbon'
                : 'border-carbon/10 text-carbon/22 cursor-not-allowed'
          ]"
          :disabled="!isOptionAvailable(opt.label, val)"
          @click="selectOption(opt.label, val)"
        >
          {{ val }}
        </button>
      </div>
    </div>

    <!-- Price display -->
    <div class="flex items-baseline gap-3 pt-2">
      <span class="font-editorial text-3xl text-carbon">
        {{ currentPrice ?? '—' }}
      </span>
      <span
        v-if="currentVariant"
        class="text-sm"
        :class="inStock ? 'text-moss' : 'text-stone'"
      >
        {{ inStock ? '有货' : '暂时缺货' }}
      </span>
    </div>
  </div>
</template>
