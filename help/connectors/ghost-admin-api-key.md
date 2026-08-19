---
sidebar_position: 3
slug: /ghost-admin-api-key
title: Ghost
---
# Connect your Ghost site to ACME.BOT

ACME.BOT publishes to your Ghost site through a custom integration that you create inside Ghost Admin. Ghost generates a pair of API credentials for that integration, and you hand those to ACME.BOT.

- **Time:** about 3 minutes
- **You need:** Owner or Administrator access to your Ghost site
- **You end up with:** an Admin API key and an API URL

## Before you start

- Sign in to Ghost Admin (`yoursite.com/ghost`) as the Owner or an Administrator. Editors and Authors can't see the Integrations page.
- Works on Ghost(Pro) and self-hosted Ghost 5.0 or later.
- You'll be handling an Admin API key, which can create and publish posts on your site. Have ACME.BOT open in another tab so you can paste it straight across.

## Steps

### 1. Open Settings in Ghost Admin

From your Ghost Admin dashboard, click **Settings** at the bottom of the left-hand sidebar.

![Open Settings in Ghost Admin](/img/help/connectors/ghost-admin-api-key/step-1.png)

### 2. Go to Integrations

In the settings sidebar, scroll to the **Advanced** section at the bottom and click **Integrations**.

![Go to Integrations](/img/help/connectors/ghost-admin-api-key/step-2.png)

### 3. Add a custom integration

The Integrations page opens on the **Built-in** tab, listing Zapier, Slack, Unsplash and the rest. Ignore those — ACME.BOT isn't one of them. Click **Add custom integration** at the top right of the Integrations panel.

Any integrations you've already made are on the **Custom** tab next to **Built-in**.

![Add a custom integration](/img/help/connectors/ghost-admin-api-key/step-3.png)

### 4. Open the name dialog

An **Add integration** dialog appears with a single **Name** field.

![Open the name dialog](/img/help/connectors/ghost-admin-api-key/step-4.png)

### 5. Name the integration and create it

Enter a name — `Acme.bot` is a good one — and click **Add**. The name is only how the integration appears in your Ghost settings; it doesn't affect the connection.

![Name the integration and create it](/img/help/connectors/ghost-admin-api-key/step-5.png)

### 6. Copy the Admin API key and API URL

Ghost creates the integration and shows its credentials: a **Content API key**, an **Admin API key**, and an **API URL**. Hover over a field and click **Copy** to copy its value.

ACME.BOT needs two of the three:

- **Admin API key** — a long value in the form `<id>:<secret>`. Copy all of it, including the colon.
- **API URL** — your site's Ghost address, such as `https://acme-test.ghost.io`.

You can leave the **Content API key** alone. That one is read-only, and ACME.BOT needs to write.

:::caution
Treat the Admin API key like a password. Anyone holding it can create and publish posts on your site. Paste it straight into ACME.BOT — don't email it or drop it in a shared doc. You can come back to this page and copy it again later; if it ever leaks, hover over the Admin API key and click **Regenerate** to invalidate the old one, then reconnect with the new value.
:::

![Copy the Admin API key and API URL](/img/help/connectors/ghost-admin-api-key/step-6.png)

Leave this tab open — you'll want to paste from it in the next step.

## Hand the credentials to ACME.BOT

### 7. Open Connectors in ACME.BOT

In ACME.BOT, click **Connectors** in the left sidebar, then click **Create Connector** at the top right of the **Publish Connector** tab.

![Open Connectors in ACME.BOT](/img/help/connectors/ghost-admin-api-key/step-7.png)

### 8. Choose the Ghost connector type

The **Connect Your Blogging Platform** screen opens on the **Connector Type** step. Click the dropdown and choose **Connector Ghost**, then click **Next**.

![Choose the Ghost connector type](/img/help/connectors/ghost-admin-api-key/step-8.png)

### 9. Open the authentication form

Step 01 of 02 is **Authentication**, with two required fields: **Ghost Site URL** and **Admin API Key**.

![Open the authentication form](/img/help/connectors/ghost-admin-api-key/step-9.png)

### 10. Paste the credentials and authorize

Fill in the two values you copied in step 6:

| Field | What to paste |
| --- | --- |
| Ghost Site URL | The **API URL** from the integration page, e.g. `https://acme-test.ghost.io` |
| Admin API Key | The full `<id>:<secret>` value — not the Content API key |

The Admin API Key field is masked as you type, so you won't be able to eyeball it for typos — paste rather than retype. Click **Authorize**. ACME.BOT calls your Ghost site to check the credentials.

![Paste the credentials and authorize](/img/help/connectors/ghost-admin-api-key/step-10.png)

### 11. Name the connector

Step 02 of 02 is **Meta Fields**. Enter a name for the connector — `Ghost` is fine — so you can identify it in the Connectors list later, then click **Save Connector**.

![Name the connector](/img/help/connectors/ghost-admin-api-key/step-11.png)

### 12. Confirm the connection

**Connection Successful!** appears, and ACME.BOT redirects you back to the Connectors list, where your new Ghost connector is now listed.

![Confirm the connection](/img/help/connectors/ghost-admin-api-key/step-12.png)

## If the connection is rejected

Work back through these:

- **The Admin API key is truncated.** It must include both halves and the colon between them. The field is narrow, so it's easy to copy only part of it — use the **Copy** button rather than selecting the text by hand.
- **You copied the Content API key.** That key is a single value with no colon, and it can only read. Make sure you took the one labelled **Admin API key**.
- **The Ghost Site URL is wrong.** Use the **API URL** value Ghost shows on the integration page — your site's root address, with no `/ghost` and no trailing slash.
- **The key was regenerated or the integration deleted.** Either one invalidates the old key immediately. Copy the current key from Ghost and reconnect.

Ghost Admin changes from release to release — the labels here may shift, but the sequence (Settings → Integrations → Add custom integration → copy Admin API key and API URL) stays the same.
