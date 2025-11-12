---
sidebar_position: 2
slug: /wordpress-application-password
title: Wordpress Application Password
---
# Connect to WordPress via Application Password

This guide provides a step-by-step walkthrough for connecting your account to a WordPress website using an application password. This method offers a secure way to authorize access to your WordPress site's API without exposing your main user password.

### Prerequisites

Before you begin, ensure you have the following:
*   An active account on the platform.
*   Administrator access to your WordPress website.
*   The Application Passwords feature is enabled on your WordPress site (this is a standard feature).

### Steps

### 1. Navigate to Connectors

From the main dashboard, locate and click on **Connectors** in the left-hand navigation menu to access the connectors management page.

![Navigate to Connectors](/img/help/connectors/wordpress-application-password/step-1.png)

### 2. Create a New Connector

On the Connector page, click the **+ Create Connector** button located in the top-right corner to begin the setup process for a new integration.

![Create a New Connector](/img/help/connectors/wordpress-application-password/step-2.png)

### 3. Select Connector Type

On the "Connect Your Blogging Platform" screen, click the dropdown menu under **Connector Type** and select **Connector Wordpress App** from the list of available options.

![Select Connector Type](/img/help/connectors/wordpress-application-password/step-3.png)

### 4. Proceed to Authentication

After selecting the connector type, click the **Next** button to move to the authentication step where you will provide your WordPress site details.

![Proceed to Authentication](/img/help/connectors/wordpress-application-password/step-4.png)

### 5. Enter Website and Username

In the Authentication form, enter your full WordPress website URL in the **Website** field and your WordPress administrator username in the **Username** field. Leave the Application Password field blank for now.

![Enter Website and Username](/img/help/connectors/wordpress-application-password/step-5.png)

### 6. Approve the Connection in WordPress

To authorize the application password, navigate to:
```
https://yourwebsite.com/wp-admin/authorize-application.php?app_name=acme-bot
```
(Replace `yourwebsite.com` with your actual WordPress site URL)

**Alternatively, you can create the application password manually:**

1. **Log in to your WordPress Admin Dashboard** (usually `yourwebsite.com/wp-admin`)
2. **Navigate to Your User Profile**
   In the left-hand menu, go to **Users > Your Profile**. (Alternatively, click your name/avatar in the top-right admin bar and select "Edit Profile")
3. **Note Your Username**
   At the top of your profile page, you'll see your **Username** field. Copy and save this username – you'll need it later for the ACME.BOT connection settings. This is your WordPress login username, not the application password name.
   ![Username](/img/help/connectors/wordpress-application-password/username.png)
4. **Scroll Down to "Application Passwords"**
   You'll find this section towards the bottom of your profile page. Enter a name for (eg., acmebot) for the application password and then click on add **Add Application Password**
   ![Application Password](/img/help/connectors/wordpress-application-password/application-password.png)
   *(Note: If you don't see this section, first check the "Pretty Permalinks" prerequisite below. If that's set correctly, a security plugin might be disabling it, or your user role might not have permission.)*

On the "Authorize Application" screen, review the details and click **Yes, I approve of this connection** to generate a new password.

![Approve the Connection in WordPress](/img/help/connectors/wordpress-application-password/step-6.png)

### 7. Copy the Application Password

WordPress will generate a unique, secure password for the application. Highlight and copy this password to your clipboard, and be sure to save it in a safe location as it will not be shown again.

![Copy the Application Password](/img/help/connectors/wordpress-application-password/step-7.png)

### 8. Enter Password and Authorize

Return to the connector setup page. Paste the copied application password into the **Application Password** field and click the **Authorize** button to verify the connection.

![Enter Password and Authorize](/img/help/connectors/wordpress-application-password/step-8.png)

### 9. Name Your Connector

After a successful connection, you will be prompted to name your connector. Enter a descriptive name in the **Connector Name** field to easily identify it later.

![Name Your Connector](/img/help/connectors/wordpress-application-password/step-9.png)

### 10. Save and Confirm

Click **Save Connector** to finalize the setup. You will be redirected back to the Connectors list, where your newly created WordPress connection will appear.

![Save and Confirm](/img/help/connectors/wordpress-application-password/step-10.png)

