// Entry point for the build script in your package.json

import Home from "./svelte/Home.svelte";

window.addEventListener("load", () => {
  if ((t = document.querySelector('[data-svelte-component="Home"]'))) {
    const app = new Home({
      target: t,
    });
  }
});
