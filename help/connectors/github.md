---
sidebar_position: 4
slug: /connectors/github
title: GitHub
---
# Connect a GitHub repository to ACME.BOT

ACME.BOT publishes to GitHub by opening a pull request that adds your post as a Markdown file. It authenticates with a fine-grained personal access token (PAT) that you create in GitHub and paste into ACME.BOT.

- **Time:** about 5 minutes
- **You need:** write access to the repository your site is built from
- **You end up with:** a fine-grained personal access token scoped to that repository

## Create a fine-grained personal access token

### 1. Open Fine-grained tokens

In GitHub, go to [Settings → Developer settings → Personal access tokens → Fine-grained tokens](https://github.com/settings/tokens?type=beta) and click **Generate new token**.

![Open Fine-grained tokens](/img/help/connectors/github/step-1.png)

### 2. Name the token and set its owner and expiration

- **Token name:** something you'll recognise later, such as `ACME.BOT publishing`.
- **Resource owner:** the account or organization that owns the repository.
- **Expiration:** pick a date. GitHub also offers **No expiration**, but recommends against it. A token with a date stops working once it passes, and you'll need to [refresh it](#refreshing-your-token).

![Name the token and set its owner and expiration](/img/help/connectors/github/step-2.png)

### 3. Choose the repository

Under **Repository access**, choose **Only select repositories**, open **Select repositories**, and pick your site's repository.

![Choose the repository](/img/help/connectors/github/step-3.png)

### 4. Set the permissions

Under **Permissions**, click **Add permissions** and add these two, then set each one's **Access** to **Read and write**:

| Permission | Access |
| --- | --- |
| Contents | Read and write |
| Pull requests | Read and write |

GitHub adds **Metadata: Read-only** on its own. ACME.BOT doesn't need anything else. Click **Generate token**, then confirm in the dialog that lists the three permissions.

![Set the permissions](/img/help/connectors/github/step-4.png)

### 5. Copy the token

GitHub shows the new token once, starting with `github_pat_`. Click the copy button next to it.

![Copy the token](/img/help/connectors/github/step-5.png)

:::caution
Treat the token like a password. Anyone holding it can push to the repository. Paste it straight into ACME.BOT, and don't email it or put it in a shared doc.
:::

:::note
If the repository belongs to an organization, an organization owner may have to approve fine-grained tokens before they work. The token shows as **Pending** in GitHub until they do.
:::

## Add the connector in ACME.BOT

### 6. Open Connectors

In ACME.BOT, click **Connectors** in the left sidebar, then click **Create Connector** at the top right of the **Publish Connector** tab.

![Open Connectors](/img/help/connectors/github/step-6.png)

### 7. Choose GitHub

The **Connect Your Blogging Platform** screen opens on **Connector Type**. Choose **GitHub** from the dropdown and click **Next**.

![Choose GitHub](/img/help/connectors/github/step-7.png)

### 8. Paste the token and repository

On **GitHub Auth**, fill in:

| Field | What to enter |
| --- | --- |
| Personal Access Token | The `github_pat_…` value you copied |
| Repository | `owner/repo`, or the repository's GitHub URL |

Click **Authorize**. ACME.BOT checks that the token can reach the repository and push to it.

![Paste the token and repository](/img/help/connectors/github/step-8.png)

### 9. Configure the repository

On **Repository Config**, set:

- **File Path Pattern:** where each post is written, such as `blog/{slug}.md`. It supports `{slug}` and `{date}`.
- **Frontmatter Template:** the frontmatter at the top of each file. Leave the default if your site doesn't need something different.
- **Auto-merge PRs:** tick this to merge each pull request automatically once it's created.
- **Connector Name:** a name to identify this connector in the list.

Click **Save Connector**.

![Configure the repository](/img/help/connectors/github/step-9.png)

### 10. Confirm the connection

**Connection Successful!** appears, and ACME.BOT takes you back to the Connectors list, where your GitHub connector is now listed.

![Connection Successful](/img/help/connectors/github/step-10.png)

![The new connector in the list](/img/help/connectors/github/step-11.png)

## Refreshing your token

If your token has an expiration date, ACME.BOT can't publish to GitHub once that date passes. You'll see one of these:

- **Before it expires:** if the token has less than 10 days left, a successful publish comes with a note: *"Your GitHub token expires in N days…"*
- **After it expires:** publishing fails with *"GitHub rejected the connector's token. If publishing worked before, the token has most likely expired…"*

To fix it, get a new token from GitHub and then connect it to ACME.BOT.

### 1. Get a new token from GitHub

The quickest way is to regenerate the token you already have:

1. Open [Fine-grained tokens](https://github.com/settings/tokens?type=beta) and click the token you made for ACME.BOT.
2. Click **Regenerate token**, choose a new expiration, and confirm.
3. Copy the new `github_pat_…` value.

Regenerating keeps the token's repository access and permissions, but the old value stops working right away. If you've deleted the old token, or want different settings, [create a new one](#create-a-fine-grained-personal-access-token) with the same permissions instead.

### 2. Update the connector in ACME.BOT

You don't need a new connector. Put the new token on the one you already have:

1. In ACME.BOT, click **Connectors** in the left sidebar, then click your GitHub connector in the list. You can also open its **⋮** menu and choose **Edit**. The **Edit Connector** window opens.
2. Open the **GitHub Auth** tab. For security, the **Personal Access Token** field is empty. Your saved token isn't shown again.
3. Paste the new `github_pat_…` value into **Personal Access Token**. Leave **Repository** as it is.
4. Click **Authorize**. ACME.BOT checks the new token against the repository, the same way it did when you first connected.

The connector keeps its name, repository, file path pattern, frontmatter template and auto-merge setting. Every agent that publishes through it uses the new token from its next publish on.

:::tip
Set a calendar reminder a few days before the new expiration date, so you can refresh the token before a publish fails.
:::

## If the connection is rejected

- **"The token does not have push access to this repository."** The token's **Contents** permission is read-only. Edit the token in GitHub and set **Contents** to **Read and write**.
- **"GitHub refused access to…"** The token is missing a permission. It needs both **Contents** and **Pull requests** set to **Read and write**.
- **"GitHub could not find the repository…"** Check the spelling of the repository, and make sure it's listed under the token's **Repository access**.
- **The token shows as Pending.** An organization owner has to approve it before it works.

GitHub's settings pages change from time to time. The labels may shift, but the sequence (Fine-grained tokens → Generate new token → pick the repository → Contents and Pull requests read and write) stays the same.
