import {
  feedjsonUrlToRssUrl,
  getCurrentTranslations,
  getFeedSiteIdentifiers,
  getGeneralTranslations,
  siteIdentifierToUrl,
  urlToLanguageUrl,
  urlToSiteIdentifier,
} from "./util.ts";
import { Config, Feedjson } from "./interface.ts";
import { TARGET_SITE_LANGUAEGS } from "./constant.ts";
import { mustache } from "./deps.ts";
export default function feedToHTML(
  feedJson: Feedjson,
  config: Config,
  indexTemplateString: string,
): string {
  const sitesMap = config.sites;
  const homepage = feedJson.home_page_url;
  if (!homepage) {
    throw new Error(`home_page_url not found for feedjson`);
  }
  const siteIdentifier = urlToSiteIdentifier(homepage, config);
  const languageCode = feedJson.language;
  if (!languageCode) {
    throw new Error(`language code not found for feedjson`);
  }
  const languages = TARGET_SITE_LANGUAEGS;
  const language = languages.find((lang) => lang.code === languageCode);
  if (!language) {
    throw new Error(`language code ${languageCode} not found`);
  }
  const currentTranslations = getGeneralTranslations(
    languageCode,
    config,
  );
  feedJson = {
    ...currentTranslations,
    ...feedJson,
  };
  // @ts-ignore: add meta data
  feedJson._languages = languages.map((item) => {
    const newItem = { ...item };
    // @ts-ignore: add meta data
    newItem.active = item.code === language.code;
    // @ts-ignore: add meta data
    newItem.url = urlToLanguageUrl(homepage, item.prefix);
    return newItem;
  });
  // related sites is has common tags sites
  const otherSites: string[] = [];
  const relatedSites = getFeedSiteIdentifiers(config).filter((site) => {
    const siteTags = sitesMap[site].tags;
    const currentSiteTags = feedJson._tags;

    // ignore self
    if (site === siteIdentifier) {
      return false;
    }
    if (siteTags && currentSiteTags) {
      const isRelated = siteTags.some((tag) => currentSiteTags.includes(tag));
      if (isRelated) {
        return true;
      } else {
        otherSites.push(site);
        return false;
      }
    } else {
      otherSites.push(site);
      return false;
    }
  });
  //@ts-ignore: add meta data
  feedJson._related_sites = relatedSites.map(
    (item, index) => {
      const siteTranslations = getCurrentTranslations(
        item,
        language.code,
        config,
      );
      const siteShortName = siteTranslations.short_title;
      const siteName = siteTranslations.title;
      return {
        //@ts-ignore: add meta data
        name: siteShortName || siteName,
        url: siteIdentifierToUrl(item, "/" + language.prefix, config),
        is_last: index === relatedSites.length - 1,
      };
    },
  );
  //@ts-ignore: add meta data
  feedJson._other_sites = otherSites.map(
    (item, index) => {
      const siteTranslations = getCurrentTranslations(
        item,
        language.code,
        config,
      );
      const siteShortName = siteTranslations.short_title;
      const siteName = siteTranslations.title;

      return {
        //@ts-ignore: add meta data
        name: siteShortName || siteName,
        url: siteIdentifierToUrl(item, "/" + language.prefix, config),
        is_last: index === otherSites.length - 1,
      };
    },
  );
  // @ts-ignore: add meta data
  feedJson._rss_url = feedjsonUrlToRssUrl(feedJson.feed_url);
  // @ts-ignore: add meta data
  // feedJson._atom_url = siteIdentifierToUrl(
  //   siteIdentifier,
  //   "/" + language.prefix + "atom.xml",
  //   config,
  // );

  // build index.html
  // @ts-ignore: js package does not have type for mustache
  const output = mustache.render(indexTemplateString, feedJson);
  return output;
}
