import type { Product } from '~/types/product'

export const products: Product[] = [
  {
    id: 'yuebai-liankou-ping',
    name: '月白敛口瓶',
    type: '手作陶瓷',
    price: '¥1,280',
    images: [
      '/images/product-vessel.png',
      '/images/product-vessel.png',
      '/images/product-vessel.png'
    ],
    description: '敛口，鼓腹，圈足微收。器型取自宋式瓶的简约比例，经手修口沿与含蓄比例，保留泥土被火安静改变的一刻。釉色月白微暖，在不同光线下呈现白中泛青的微妙层次。',
    details: [
      '手拉坯成型，高温还原焰烧制',
      '月白釉，哑光质感',
      '适用于花器、茶席或单独陈设',
      '每件器物因手工制作，尺寸与釉色均有细微差异'
    ],
    materials: '景德镇高白泥 / 月白釉',
    dimensions: '口径 4.5cm × 腹径 12cm × 高 18cm',
    care: '避免突然冷热交替，以软布清洁即可',
    skuOptions: [
      { label: '尺寸', values: ['标准', '小号'] },
      { label: '釉色', values: ['月白', '青灰'] }
    ],
    skuVariants: [
      { sku: 'YBP-S-M', options: { '尺寸': '标准', '釉色': '月白' }, price: '¥1,280', stock: true },
      { sku: 'YBP-S-G', options: { '尺寸': '标准', '釉色': '青灰' }, price: '¥1,280', stock: true },
      { sku: 'YBP-L-M', options: { '尺寸': '小号', '釉色': '月白' }, price: '¥980', stock: false },
      { sku: 'YBP-L-G', options: { '尺寸': '小号', '釉色': '青灰' }, price: '¥980', stock: true }
    ],
    relatedIds: ['suma-changjin', 'xuanxi-woxiang-zuo']
  },
  {
    id: 'suma-changjin',
    name: '素麻长巾',
    type: '水洗亚麻',
    price: '¥620',
    images: [
      '/images/product-linen-runner.png',
      '/images/product-linen-runner.png',
      '/images/product-linen-runner.png'
    ],
    description: '经过水洗与日晒的天然亚麻，手感柔软却有筋骨。经纬之间留有轻微的不规则纹理，记录着天然纤维的生长记忆。可以做为桌旗、披肩或悬挂的软性分割。',
    details: [
      '100% 欧洲雨露亚麻',
      '酵素水洗处理，自然皱褶感',
      '两端手工抽须装饰',
      '可机洗，越用越柔软'
    ],
    materials: '100% 欧洲雨露亚麻',
    dimensions: '40cm × 180cm',
    care: '30°C以下机洗，自然晾干，中温熨烫',
    skuOptions: [
      { label: '颜色', values: ['本色', '灰白'] }
    ],
    skuVariants: [
      { sku: 'SML-N', options: { '颜色': '本色' }, price: '¥620', stock: true },
      { sku: 'SML-GW', options: { '颜色': '灰白' }, price: '¥620', stock: true }
    ],
    relatedIds: ['yuebai-liankou-ping', 'xuanxi-woxiang-zuo']
  },
  {
    id: 'xuanxi-woxiang-zuo',
    name: '玄石卧香座',
    type: '石陶复合',
    price: '¥760',
    images: [
      '/images/product-incense-holder.png',
      '/images/product-incense-holder.png',
      '/images/product-incense-holder.png'
    ],
    description: '以玄石色陶泥与天然石粉复合而成，表面保留手工揉泥的肌理与细微气孔。卧香槽浅而长，适合塔香或线香。木、陶、石之间的微小尺度，让气息缓慢升起。',
    details: [
      '陶泥与石粉复合胎体',
      '手工雕刻香槽',
      '适配塔香、线香、盘香',
      '底部附软木垫，保护桌面'
    ],
    materials: '玄色陶泥 / 天然石粉',
    dimensions: '8cm × 3cm × 1.5cm',
    care: '干燥软布擦拭，避免浸水',
    skuOptions: [
      { label: '材质', values: ['玄石陶', '素陶'] }
    ],
    skuVariants: [
      { sku: 'XWX-XST', options: { '材质': '玄石陶' }, price: '¥760', stock: true },
      { sku: 'XWX-ST', options: { '材质': '素陶' }, price: '¥680', stock: true }
    ],
    relatedIds: ['yuebai-liankou-ping', 'zhiying-yedeng']
  },
  {
    id: 'zhiying-yedeng',
    name: '纸影夜灯',
    type: '楮纸与胡桃木',
    price: '¥1,460',
    images: [
      '/images/product-stone-lamp.png',
      '/images/product-stone-lamp.png',
      '/images/product-stone-lamp.png'
    ],
    description: '灯罩以手工楮纸裱糊，保留纤维透光的自然层次。底座选用北美黑胡桃木，表面手工打磨至丝滑触感。暖光透过纸层时变得柔软而安静，适合黄昏、雨日与一间足够安静的屋子。',
    details: [
      '手工楮纸灯罩，透光均匀',
      '北美黑胡桃木底座',
      'E14 暖光灯泡 (2200K, 可更换)',
      '触摸无级调光'
    ],
    materials: '手工楮纸 / 北美黑胡桃木',
    dimensions: '灯罩 φ16cm × 高20cm / 底座 φ12cm',
    care: '灯罩以软毛刷轻拂除尘，底座以干布擦拭',
    skuOptions: [
      { label: '灯色', values: ['暖白', '琥珀'] },
      { label: '底座', values: ['胡桃木', '黑胡桃'] }
    ],
    skuVariants: [
      { sku: 'ZYD-W-H', options: { '灯色': '暖白', '底座': '胡桃木' }, price: '¥1,460', stock: true },
      { sku: 'ZYD-A-H', options: { '灯色': '琥珀', '底座': '胡桃木' }, price: '¥1,560', stock: true },
      { sku: 'ZYD-W-BW', options: { '灯色': '暖白', '底座': '黑胡桃' }, price: '¥1,460', stock: false },
      { sku: 'ZYD-A-BW', options: { '灯色': '琥珀', '底座': '黑胡桃' }, price: '¥1,560', stock: true }
    ],
    relatedIds: ['xuanxi-woxiang-zuo', 'yuebai-liankou-ping']
  }
]

export function getProductById(id: string): Product | undefined {
  return products.find(p => p.id === id)
}

export function getRelatedProducts(ids: string[]): Product[] {
  return products.filter(p => ids.includes(p.id))
}
