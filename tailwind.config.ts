import type { Config } from 'tailwindcss'

export default <Partial<Config>>{
  content: [
    './app/**/*.{vue,js,ts}',
    './components/**/*.{vue,js,ts}'
  ],
  theme: {
    extend: {
      colors: {
        rice: '#f4f1ea',
        paper: '#ebe4d8',
        linen: '#d7c9b7',
        clay: '#b06b4e',
        rust: '#8f4e3d',
        moss: '#5d6950',
        stone: '#8d887c',
        ash: '#c6c0b4',
        carbon: '#262722',
        ink: '#191916'
      },
      fontFamily: {
        serif: ['"Noto Serif SC"', '"Source Han Serif SC"', '"Songti SC"', 'Georgia', 'serif'],
        sans: ['Inter', '"Noto Sans SC"', '"Source Han Sans SC"', 'Arial', 'sans-serif']
      },
      boxShadow: {
        soft: '0 24px 80px rgba(38, 39, 34, 0.12)'
      }
    }
  }
}
