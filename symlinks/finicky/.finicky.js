// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Brave Browser",

  handlers: [
    {
      match: ["reaktor.com/*", "*.reaktor.com/*", "reaktor.fi/*", "*.reaktor.fi/*", "sites.google.com/reaktor.fi/*", "supercell.com/*", "*.supercell.com/*", "labycore.net/*", "*.labycore.net/*", "supercell.monday.com/*", "github.com/supercell/*", "github.com/reaktor/*", "reaktor.slack.com/*", "supercell.enterprise.slack.com/*", "supercellcom.atlassian.net/*", "supercell.zoom.us/*", "linear.app/supercell/*"],
      browser: { 
        name: "Brave Browser",
        profile: "Profile 1",
      }
    },
    {
      // Open links in work profile when the option key is pressed
      match: () => finicky.getKeys().option,
      browser: { 
        name: "Brave Browser",
        profile: "Profile 1",
      }
    },
    {
      match: "*",
      browser: { 
        name: "Brave Browser",
        profile: "Default",
      }
    },
  ],
  rewrite: [
    {
      match: () => true, // Execute rewrite on all incoming urls to make this example easier to understand
      url({ url }) {
        const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
        const removeKeys = ["fblid", "gclid"]; // Remove all query parameters matching these keys

        const search = url.search
          .split("&")
          .map((parameter) => parameter.split("="))
          .filter(([key]) => !removeKeysStartingWith.some((startingWith) => key.startsWith(startingWith)))
          .filter(([key]) => !removeKeys.some((removeKey) => key === removeKey));

        return {
          ...url,
          search: search.map((parameter) => parameter.join("=")).join("&"),
        };
      }
    }
  ]
}
