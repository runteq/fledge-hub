module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
    boxShadow: {
      // Chrome検索フォームオートコンプリートを使用時の背景色を変更しない様に対応
      autocomplete: '0 0 0 1000px white inset'
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
