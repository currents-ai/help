---
sidebar_position: 1
slug: /how-to-create-shopify-api-key
title: Shopify
---
# How to Create a Shopify API Key for ACME.BOT

This guide walks through the necessary steps within the Shopify admin dashboard to generate a custom private application. This process creates the Admin API access token and API key required for ACME.BOT to securely connect and publish content directly to your Shopify blog.

## Prerequisites

*   Administrative access to your Shopify store.
*   The ability to install custom apps (developer mode enabled).

## Steps

### Navigate to Settings


From the main Shopify dashboard, click on the **Settings** option, which is typically located in the bottom-left corner of the navigation menu. This will open the general store configuration page.

![Navigate to Settings](/img/help/agents/shopify-api-key-creation/step-1.png)

### Go to Apps and Sales Channels


In the settings menu that appears, locate and click the **Apps and sales channels** option. This section manages all installed applications and provides access to custom app development tools.

![Go to Apps and Sales Channels](/img/help/agents/shopify-api-key-creation/step-2.png)

### Access App Development


On the Apps and sales channels page, look for the main content area and click the **Develop apps** button, usually found in the top-right corner, to proceed to the custom app creation environment.

![Access App Development](/img/help/agents/shopify-api-key-creation/step-3.png)

### Allow Custom App Development


If this is your first time setting up a custom app, you will need to enable developer mode. Click the **Allow custom app development** button to initiate the necessary permissions change for your store.

![Allow Custom App Development](/img/help/agents/shopify-api-key-creation/step-4.png)

### Confirm Custom App Development


A confirmation modal will appear, warning you about the risks associated with custom app development. Review the terms and click **Allow custom app development** again to proceed and enable the feature.

![Confirm Custom App Development](/img/help/agents/shopify-api-key-creation/step-5.png)

### Create a New App


Once custom app development is enabled, click the **Create an app** button. This will launch a configuration popup where you can define the details for your new integration.

![Create a New App](/img/help/agents/shopify-api-key-creation/step-6.png)

### Name the App 'ACME.BOT'


In the pop-up window, enter the name 'ACME.BOT' in the App name field. Ensure the Developer is listed correctly, and then click **Create app** to finalize the app shell setup.

![Name the App 'ACME.BOT'](/img/help/agents/shopify-api-key-creation/step-7.png)

### Configure Admin API Scopes


The app overview page will load. To grant the necessary permissions for ACME.BOT to write blog posts, click on **Configure Admin API scopes**.

![Configure Admin API Scopes](/img/help/agents/shopify-api-key-creation/step-8.png)

### Select Required API Permissions


In the filtering search box, type `blog` or `content` to quickly find the relevant scopes. Check the boxes for both **write\_content** and **read\_content** to grant the app permission to manage blog posts.

![Select Required API Permissions](/img/help/agents/shopify-api-key-creation/step-9.png)

### Save the Configuration


After ensuring that both required content scopes (`read_content` and `write_content`) are checked, scroll to the top or bottom of the page and click the blue **Save** button to apply the new permissions.

![Save the Configuration](/img/help/agents/shopify-api-key-creation/step-10.png)

### Go to API Credentials Tab


The app configuration is complete. Now, click on the **API credentials** tab at the top of the screen to install the app and retrieve your access token.

![Go to API Credentials Tab](/img/help/agents/shopify-api-key-creation/step-11.png)

### Install the Custom App


In the Admin API access token section, click the **Install app** button. This action makes the app active and generates the unique security token you need.

![Install the Custom App](/img/help/agents/shopify-api-key-creation/step-12.png)

### Confirm Installation


A final confirmation popup will appear. Click **Install** to confirm that you want to activate the ACME.BOT custom app on your Shopify store.

![Confirm Installation](/img/help/agents/shopify-api-key-creation/step-13.png)

### Reveal the Access Token


After installation, the Admin API access token field will display a hidden value. Click **Reveal token once** to show the security key. Remember that this token is only shown this one time, so copy it immediately.

![Reveal the Access Token](/img/help/agents/shopify-api-key-creation/step-14.png)

### Copy the Admin API Token


The token is now visible. Click the copy icon next to the token or manually highlight and copy the full string. This is the API token you will enter into ACME.BOT to complete the integration setup.

![Copy the Admin API Token](/img/help/agents/shopify-api-key-creation/step-15.png)