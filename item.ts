import { Author, FormatedItem, Link, ParsedFilename } from "./interface.ts";
import {
  domainToPath,
  getDataFormatedPath,
  getDataRawPath,
  getDataTranslatedPath,
  getFullDay,
  getFullMonth,
  getFullYear,
  isMock,
  pathToDomain,
} from "./util.ts";
import { MAX_ITEMS_PER_PAGE } from "./constant.ts";
import { DOMParser, getMetadata } from "./deps.ts";
import log from "./log.ts";
export default class Item {
  originalItem: Record<string, unknown>;
  private targetSite: string;
  private image: string | null | undefined;
  static parseItemIdentifier(fileBasename: string): ParsedFilename {
    // remove extension
    let filename = fileBasename;
    if (filename.endsWith(".json")) {
      filename = filename.slice(0, -5);
    }
    const parts = filename.split("--");
    // first will be safe part, other will be the id parts
    const safePart = parts[0];
    const symParts = safePart.split("-");
    const year = symParts[0];
    const month = symParts[1];
    const day = symParts[2];
    const language = symParts[3];
    const type = symParts[4];
    const targetSitePath = symParts[5];
    const targetSite = pathToDomain(targetSitePath);
    const idParts = parts.slice(1);
    const id = idParts.join("--");
    return {
      id,
      year,
      month,
      day,
      language,
      type,
      targetSite,
      targetSitePath,
    };
  }
  static getTranslatedPath(filename: string): string {
    const parsed = Item.parseItemIdentifier(filename);
    const now = new Date();
    return `${getDataTranslatedPath()}/${parsed.targetSitePath}/${
      getFullYear(now)
    }/${getFullMonth(now)}/${getFullDay(now)}/${filename}`;
  }

  constructor(originalItem: Record<string, unknown>, targetSite: string) {
    this.originalItem = originalItem;
    this.targetSite = targetSite;
  }
  getTargetSite(): string {
    return this.targetSite;
  }
  getTargetSitePath(): string {
    return domainToPath(this.targetSite);
  }
  getType(): string {
    return this.constructor.name;
  }
  getPublished(): string {
    return this.getPublishedDate().toISOString();
  }
  getPublishedDate(): Date {
    return new Date(0);
  }

  getPublishedYear(): string {
    return getFullYear(this.getPublishedDate());
  }
  getPublishedMonth(): string {
    return getFullMonth(this.getPublishedDate());
  }
  getPublishedDay(): string {
    return getFullDay(this.getPublishedDate());
  }
  getModifiedDate(): Date {
    return new Date();
  }
  getModified(): string {
    return this.getModifiedDate().toISOString();
  }
  getModifiedYear(): string {
    return getFullYear(this.getModifiedDate());
  }
  getModifiedMonth(): string {
    return getFullMonth(this.getModifiedDate());
  }
  getModifiedDay(): string {
    return getFullDay(this.getModifiedDate());
  }
  getId(): string {
    return "";
  }
  getTitle(): string {
    return "";
  }
  getUrl(): string {
    return "";
  }
  getDomain(): string {
    return new URL(this.getUrl()).hostname;
  }
  getImage(): string | undefined | null {
    // undefined means not init
    // null means no image
    const url = this.getUrl();
    const urlObj = new URL(url);
    const domain = urlObj.hostname;
    // ignore specific domain
    if (domain === "news.ycombinator.com") {
      return null;
    }
    return undefined;
  }
  async tryToLoadImage(): Promise<string | null> {
    if (isMock()) {
      this.image = null;
      return null;
    }
    const url = this.getUrl();
    // add domain referrer
    const targetSite = this.getTargetSite();
    log.debug(`try to load image for ${url}`);
    let resource: { text: string; contentType: string };
    try {
      resource = await fetch(url, {
        referrer: `https://${targetSite}`,
      }).then(async (res) => {
        if (res.ok) {
          const contentType = res.headers.get("content-type");
          if (contentType && contentType.includes("text/html")) {
            const text = await res.text();
            return {
              text: text,
              contentType: contentType,
            };
          } else {
            throw new Error(
              `fetch ${url} failed, content type is not text/html, it is ${contentType}`,
            );
          }
        } else {
          throw new Error(`fetch ${url} failed`);
        }
      });
    } catch (e) {
      log.debug(e.message);
      this.image = null;
      return null;
    }

    const doc = new DOMParser().parseFromString(
      resource.text,
      "text/html",
    );

    const metadata = getMetadata(doc, url);
    if (metadata.image) {
      this.image = metadata.image;
      return metadata.image;
    } else {
      this.image = null;
    }
    return null;
  }
  getLinks(): Link[] {
    return [];
  }
  getAuthors(): Author[] {
    return [];
  }
  getItemIdentifier(): string {
    return `${this.getPublishedYear()}-${this.getPublishedMonth()}-${this.getPublishedDay()}-${this.getLanguage()}-${this.getType()}-${this.getTargetSitePath()}--${this.getId()}`;
  }
  getLanguage(): string {
    return "en";
  }
  getRawPath(): string {
    return `${getDataRawPath()}/${(this
      .getTargetSitePath())}/${this.getModifiedYear()}/${this.getModifiedMonth()}/${this.getModifiedDay()}/${this.getItemIdentifier()}.json`;
  }
  getFormatedPath(): string {
    return `${getDataFormatedPath()}/${(this
      .getTargetSitePath())}/${this.getModifiedYear()}/${this.getModifiedMonth()}/${this.getModifiedDay()}/${this.getItemIdentifier()}.json`;
  }
  getExternalUrl(): string | undefined {
    return undefined;
  }
  getTranslations(): Record<string, string> {
    return {
      "title": this.getTitle(),
    };
  }
  async getFormatedItem(): Promise<FormatedItem> {
    const externalUrl = this.getExternalUrl();
    const translations: Record<string, Record<string, string>> = {};
    translations[this.getLanguage()] = this.getTranslations();
    let image = this.getImage();
    if (image === undefined) {
      await this.tryToLoadImage();
      image = this.image;
    }
    const item: FormatedItem = {
      id: this.getItemIdentifier(),
      url: this.getUrl(),
      date_published: this.getPublished(),
      date_modified: this.getModified(),
      _original_language: this.getLanguage(),
      tags: this.getTags(),
      authors: this.getAuthors(),
      _links: this.getLinks(),
      _translations: translations,
    };
    if (image) {
      item.image = image;
    }
    if (externalUrl) {
      item.external_url = externalUrl;
    }
    return item;
  }
  getTags(): string[] {
    return [];
  }
}
