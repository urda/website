/** @type {import("stylelint").Config} */
export default {
  extends: ["stylelint-config-standard-scss"],
  ignoreFiles: ["style.scss"],
  rules: {
    "color-function-alias-notation": "with-alpha",
    "color-function-notation": "legacy",
    "scss/no-global-function-names": null,
  },
};
