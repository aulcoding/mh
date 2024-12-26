module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {},
  },
  plugins: [require('daisyui')], // Add DaisyUI here
  daisyui: {
    themes: ["light", "dark"], // You can customize themes here

  }
}

