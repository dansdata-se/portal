const cardRadius = "0.75rem";
const maxCardSpacing = "0.5rem";
const buttonsSpacing = "0.5rem";

module.exports = {
  theme: {
    extends: {
      borderRadius: {
        "md-comp-card-radius": cardRadius,
        "card-radius": cardRadius,
      },
      gap: {
        // md-comp-card-spacing-between
        "card-grid": maxCardSpacing,
        //md-comp-card-buttons-spacing-between
        "card-buttons": buttonsSpacing,
      },
      spacing: {
        "md-comp-card-content-padding": "1rem",
        "md-comp-card-spacing-between": maxCardSpacing,
        "md-comp-card-buttons-spacing-between": buttonsSpacing,
      },
    },
  },
};
