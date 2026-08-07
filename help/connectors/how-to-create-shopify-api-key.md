---
sidebar_position: 1
slug: /how-to-create-shopify-api-key
title: Shopify
---
# Connect your Shopify blog to ACME.BOT

ACME.BOT publishes to your store's blog through a custom Shopify app that you create and own. You build the app in Shopify's dev dashboard, give it permission to read and write store content, install it on your store, then hand ACME.BOT the two credentials it generates.

- **Time:** about 7 minutes
- **You need:** Shopify store owner access
- **You end up with:** a Client ID and a Secret

## Before you start

- Sign in to your Shopify admin with an account that can create apps. The store owner always can; staff accounts need the app development permission.
- You'll be handling your store's API secret. Have ACME.BOT open in another tab so you can paste it straight across.
- Do the steps in order. The app has to be released and installed before the credentials will work.

## Steps

### 1. Open the Apps settings in your Shopify admin

From your store admin, go to **Settings → Apps**. This is the page that gives you access to app development for your store. Use **Develop apps** — not the App Store — to reach the dev dashboard.

![Open the Apps settings in your Shopify admin](/img/help/connectors/shopify-api-key-creation/step-1.png)

### 2. Go to the dev dashboard

If clicking **Develop apps** doesn't take you to the dev dashboard directly, Shopify shows an **App development** section with a **Build apps in Dev Dashboard** button and a **Learn more** link. Click **Build apps in Dev Dashboard** to open the dev dashboard.

![App development section with the Build apps in Dev Dashboard button](/img/help/connectors/shopify-api-key-creation/step-2a.png)

Sometimes the section appears without the button — only the **Learn more** link:

![App development section without the button](/img/help/connectors/shopify-api-key-creation/step-2b.png)

If that happens, pick whichever of these is easier — you only need one; both end up in the same place:

- **Either** go straight to [https://dev.shopify.com/dashboard](https://dev.shopify.com/dashboard) in your browser,
- **or** click **Learn more**, which opens Shopify's dev docs, and click **Log in** at the top right (highlighted below) — if you're already logged in to Shopify, it redirects you straight to your dev dashboard's Apps page (`dev.shopify.com/dashboard/…/apps`).

![Shopify dev docs — Log in at the top right leads to the dev dashboard](/img/help/connectors/shopify-api-key-creation/step-2c.png)

### 3. Start a new app

In the dev dashboard, click **Create app** in the "Get API credentials" banner at the bottom, or open **Apps → Create app**. Ignore the Shopify CLI instructions — you don't need to install anything.

![Start a new app in the dev dashboard](/img/help/connectors/shopify-api-key-creation/step-2.png)

### 4. Name the app and create it

Choose **Start from Dev Dashboard** on the right — that's the path that hands you API credentials directly. Enter a name for the app — anything works, such as `Acme.Bot` or `Acme blog` — then click **Create**. Whatever you choose is just how the app will appear in your store's app list; it doesn't affect the connection.

![Name the app and create it](/img/help/connectors/shopify-api-key-creation/step-3.png)

### 5. Fill in the App URL

On the **Create version** screen, enter any valid URL in the **App URL** field — `https://example.com` works. Leave **Embed app in Shopify admin** checked and the webhooks API version at its default. App URL is a required field, not a real destination; nothing is served from it.

![Fill in the App URL](/img/help/connectors/shopify-api-key-creation/step-4.png)

### 6. Grant the app access to store content

Scroll down to the **API access** section and click **Select scopes** next to **Scopes**. A dialog opens with a search box at the top. Type `content` into it — this filters the scope list rather than adding anything, and the matching scopes appear grouped under **Admin API → Store content**. Tick the two you need, **read_content** and **write_content**, then click **Done**.

Those two scopes are what let ACME.BOT read your existing blog posts and publish new ones. Leave the Storefront API scope (`unauthenticated_read_content`) unchecked.

![Grant the app access to store content](/img/help/connectors/shopify-api-key-creation/step-5.png)

### 7. Confirm the scopes, then release

Back on the form, the **Scopes** box should read exactly `read_content,write_content`. Leave **Optional scopes**, **legacy install flow**, and **Redirect URLs** empty. Click **Release**.

:::tip
If the Scopes box is empty, the dialog didn't save — reopen **Select scopes** and try again.
:::

![Confirm the scopes, then release](/img/help/connectors/shopify-api-key-creation/step-6.png)

### 8. Name the version and confirm

Shopify asks you to name the release. Anything works — `v1` is fine. Click **Release** to confirm. A version is a snapshot of the app's config; changing scopes later means releasing a new one.

![Name the version and confirm](/img/help/connectors/shopify-api-key-creation/step-7.png)

### 9. Install the app on your store

Now install the app on your store. Click the app's name in the left sidebar (here it's **acme blog**) to open its **Overview** page. In the **Installs** panel at the top right — the count still reads 0 — click **Install app**.

Until this is done, the credentials exist but grant access to nothing, and ACME.BOT's connection will fail.

![Install the app on your store](/img/help/connectors/shopify-api-key-creation/step-8.png)

### 10. Pick the store to install it on

Shopify asks which store the app belongs to. Choose your store from the list. If you manage several stores, make sure you pick the one whose blog ACME.BOT should publish to.

![Pick the store to install it on](/img/help/connectors/shopify-api-key-creation/step-9.png)

### 11. Approve the permissions and install

The install screen lists what the app can reach — staff and contributor data, and store data for the Online Store. That's the `read_content` / `write_content` access from step 6, described in plain language. Click **Install**.

:::note
The yellow "This app hasn't been reviewed" banner is expected. Shopify only reviews apps distributed through its App Store. This one is a private app you just built for your own store, so there's nothing to review.
:::

![Approve the permissions and install](/img/help/connectors/shopify-api-key-creation/step-10.png)

### 12. Confirm the app is installed

The app now appears under **Apps** in your store's left sidebar. Opening it shows the placeholder page at `example.com` from step 5 — that's expected and harmless. The app has no interface of its own; ACME.BOT talks to it through the API.

![Confirm the app is installed](/img/help/connectors/shopify-api-key-creation/step-11.png)

### 13. Copy the Client ID and Secret

Head back to the dev dashboard and open your app (`dev.shopify.com/dashboard` → your app). If you're not already on the **Settings** tab, click it in the left sidebar. Under **Credentials**, copy the **Client ID**, then click the eye icon to reveal the **Secret** and copy that too.

:::caution
Treat the Secret like a password. Anyone holding it can write to your store's content. Paste it straight into ACME.BOT — don't email it or drop it in a shared doc. You can come back and reveal it again later; if it ever leaks, click **Rotate** and reconnect with the new one.
:::

![Copy the Client ID and Secret](/img/help/connectors/shopify-api-key-creation/step-12.png)

## Hand the credentials to ACME.BOT

In ACME.BOT, add the Shopify connector and paste in these values. That's the last step — ACME.BOT can then read your existing posts and publish new ones to your blog.

| Value | Where it comes from |
| --- | --- |
| Store domain | Your `*.myshopify.com` address — shown next to your store name in Shopify |
| Client ID | The app's **Settings → Credentials** panel (step 13) |
| Secret | The same panel — click the eye icon to reveal it (step 13) |

## If the connection is rejected

Work back through three things:

- The app was never installed on the store (steps 9–12).
- The version wasn't released, so it isn't active (steps 7–8).
- The scopes didn't save (step 7).

Shopify's admin changes often — the labels here may shift, but the sequence (create app → add content scopes → release → install on store → copy credentials) stays the same.
