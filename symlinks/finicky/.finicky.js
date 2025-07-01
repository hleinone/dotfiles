// @ts-check

/**
 * @typedef {import('/Applications/Finicky.app/Contents/Resources/finicky.d.ts').FinickyConfig} FinickyConfig
 */

/**
 * @type {FinickyConfig}
 */
export default {
  defaultBrowser: "Brave Browser",

  handlers: [
    {
      match: ["reaktor.com/*", "*.reaktor.com/*", "reaktor.fi/*", "*.reaktor.fi/*", "sites.google.com/reaktor.fi/*", "supercell.com/*", "*.supercell.com/*", "labycore.net/*", "*.labycore.net/*", "supercell.monday.com/*", "github.com/supercell/*", "github.com/reaktor/*", "reaktor.slack.com/*", "supercell.enterprise.slack.com/*", "supercellcom.atlassian.net/*", "supercell.zoom.us/*", "linear.app/supercell/*", "supercell.sentry.io/*"],
      browser: { 
        name: "Brave Browser",
        profile: "Profile 1",
      }
    },
    {
      // Open links in work profile when the option key is pressed
      match: () => finicky.getModifierKeys().option,
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
  ]
}
