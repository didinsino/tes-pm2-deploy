module.exports = {
  apps: [
    {
      name: "my-hono-app",
      script: "bun",
      args: "run src/index.ts",
      interpreter: "none",
      env: {
        NODE_ENV: "production",
        PORT: 3000,
      },
    },
  ],

  deploy: {
    production: {
      user: "ti-didin",
      host: "192.168.191.103",
      port: "2222",
      ref: "origin/main",
      repo: "https://github.com/didinsino/tes-pm2-deploy.git",
      path: "/home/ti-didin/test/my-hono-app",
      "pre-deploy-local": "",
      "post-deploy":
        "bun install && pm2 reload ecosystem.config.js --env production",
      "pre-setup": "",
    },
  },
};
