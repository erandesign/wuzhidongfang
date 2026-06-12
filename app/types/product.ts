export interface SkuOption {
  label: string
  values: string[]
}

export interface SkuVariant {
  sku: string
  options: Record<string, string>
  price: string
  stock: boolean
}

export interface Product {
  id: string
  name: string
  type: string
  price: string
  images: string[]
  description: string
  details: string[]
  materials: string
  dimensions: string
  care: string
  skuOptions: SkuOption[]
  skuVariants: SkuVariant[]
  relatedIds: string[]
}
