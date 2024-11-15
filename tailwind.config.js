module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    fontFamily: {
      handwritten: ["Darumadrop One"],
      body: ["Zen Kaku Gothic New"],
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        mytheme: {
          "base-200": "#FFEDCC",
          "base-100": "#FFF8DC",
          "primary": "#88C273",
          "secondary": "#FFB0B0",
          "accent": "#FFD09B",
        },
      },
    ],
  },
  extend: {
    fontFamily: {
      handwritten: ["Darumadrop One"],
      body: ["Zen Kaku Gothic New"],
    },
  },
};
