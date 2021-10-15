// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Brave Browser",

  handlers: [
    {
      match: ["reaktor.com/*", "reaktor.fi/*", "supercell.com/*", "*.reaktor.com/*", "*.reaktor.fi/*", "*.supercell.com/*", "supercell.monday.com/*", "github.com/supercell/*", "github.com/reaktor/*"],
      browser: { 
        name: "Brave Browser",
        profile: "Profile 1", 
      }
    },
  ]
}
