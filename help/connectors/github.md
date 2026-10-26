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

1. In GitHub, open [Settings → Developer settings → Personal access tokens → Fine-grained tokens](https://github.com/settings/tokens?type=beta) and click **Generate new token**.
2. Give the token a name you'll recognise later, such as `ACME.BOT publishing`.
3. Pick an **Expiration**. GitHub requires one for fine-grained tokens, so the token will run out at some point. When it does, follow [Refreshing your token](#refreshing-your-token).
4. Under **Resource owner**, choose the account or organization that owns the repository.
5. Under **Repository access**, choose **Only select repositories** and select your site's repository.
6. Under **Repository permissions**, set:

   | Permission | Access |
   | --- | --- |
   | Contents | Read and write |
   | Pull requests | Read and write |

   GitHub adds **Metadata: Read-only** on its own. ACME.BOT doesn't need anything else.
7. Click **Generate token** and copy the value. It starts with `github_pat_`, and GitHub shows it only once.

:::caution
Treat the token like a password. Anyone holding it can push to the repository. Paste it straight into ACME.BOT, and don't email it or put it in a shared doc.
:::

:::note
If the repository belongs to an organization, an organization owner may have to approve fine-grained tokens before they work. The token shows as **Pending** in GitHub until they do.
:::

## Add the connector in ACME.BOT

1. In ACME.BOT, click **Connectors** in the left sidebar, then click **Create Connector**.
2. Choose **GitHub** as the connector type and click **Next**.
3. On **GitHub Auth**, fill in:

   | Field | What to enter |
   | --- | --- |
   | Personal Access Token | The `github_pat_…` value you copied |
   | Repository | `owner/repo`, or the repository's GitHub URL |

   Click **Authorize**. ACME.BOT checks that the token can reach the repository and push to it.
4. On **Repository Config**, set:
   - **File Path Pattern**: where each post is written, such as `blog/{slug}.md`. It supports `{slug}` and `{date}`.
   - **Frontmatter Template**: the frontmatter at the top of each file. Leave the default if your site doesn't need something different.
   - **Auto-merge PRs**: tick this to merge each pull request automatically once it's created.
   - **Connector Name**: a name to identify this connector in the list.
5. Click **Save Connector**.

## Refreshing your token

Fine-grained tokens always expire, and ACME.BOT can't publish to GitHub once yours does. You'll see one of these:

- **Before it expires:** if the token has less than 10 days left, a successful publish comes with a note: *"Your GitHub token expires in N days…"*
- **After it expires:** publishing fails with *"GitHub rejected the connector's token. If publishing worked before, the token has most likely expired…"*

To fix it, get a new token from GitHub and then connect it to ACME.BOT.

### 1. Get a new token from GitHub

The quickest way is to regenerate the token you already have:

1. Open [Fine-grained tokens](https://github.com/settings/tokens?type=beta) and click the token you made for ACME.BOT.
2. Click **Regenerate token**, choose a new expiration, and confirm.
3. Copy the new `github_pat_…` value.

Regenerating keeps the token's repository access and permissions, but the old value stops working right away. If you've deleted the old token, or want different settings, [create a new one](#create-a-fine-grained-personal-access-token) with the same permissions instead.

### 2. Connect the new token to ACME.BOT

You can't swap the token on an existing connector. Saving the old connector with a new token doesn't change the token it publishes with. Create a replacement connector instead:

1. In **Connectors**, open your current GitHub connector and write down its **Repository**, **File Path Pattern**, **Frontmatter Template**, and **Auto-merge PRs** settings.
2. Make sure the agent that publishes to this repository is the one selected, then click **Create Connector** and follow [Add the connector in ACME.BOT](#add-the-connector-in-acmebot). Use the new token and the settings you wrote down.
3. The new connector becomes that agent's default, so its next publish goes through the new token.
4. Delete the old GitHub connector from the Connectors list. If other agents still publish through it, move them to the new connector first.

:::tip
Set a calendar reminder a few days before the new expiration date, so you can refresh the token before a publish fails.
:::

## If the connection is rejected

- **"The token does not have push access to this repository."** The token's **Contents** permission is read-only. Edit the token in GitHub and set **Contents** to **Read and write**.
- **"GitHub refused access to…"** The token is missing a permission. It needs both **Contents** and **Pull requests** set to **Read and write**.
- **"GitHub could not find the repository…"** Check the spelling of the repository, and make sure it's listed under the token's **Repository access**.
- **The token shows as Pending.** An organization owner has to approve it before it works.
