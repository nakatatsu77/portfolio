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
  plugins: [
    plugin(function ({ addUtilities }) {
      const newUtilities = {
        ".horizontal-tb": {
          writingMode: "horizontal-tb",
        },
        ".vertical-rl": {
          writingMode: "vertical-rl",
          "-ms-writing-mode": "tb-rl",
        },
        ".vertical-lr": {
          writingMode: "vertical-lr",
        },
        ".rtl": {
          direction: "rtl",
        },
      };
      addUtilities(newUtilities);
    }),
   require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          "base-200": "#FFEDCC",
          "base-100": "#FFF8DC",
          "primary": "#88C273",
          "secondary": "#FFB0B0",
          "accent": "#FFD09B",
          "neutral": "#FEFEFE",
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
