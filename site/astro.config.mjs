import { defineConfig } from "astro/config";
import tailwindcss from "@tailwindcss/vite";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://paulo-amaral.github.io/easyscp",
  integrations: [sitemap()],
  vite: { plugins: [tailwindcss()] },
});
